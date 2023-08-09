local ts_locals = require("nvim-treesitter.locals")
local ts_utils = require("nvim-treesitter.ts_utils")

local transforms = {
  int = function(_, _)
    return t("0")
  end,

  bool = function(_, _)
    return t("false")
  end,

  string = function(_, _)
    return t([[""]])
  end,

  error = function(_, info)
    if info then
      info.index = info.index + 1

      return c(info.index, {
        t(info.err_name),
        t(string.format("errors.Wrap(%s)", info.err_name)),
      })
    else
      return t("err")
    end
  end,

  -- Types with a "*" mean they are pointers, so return nil
  [function(text)
    return string.find(text, "*", 1, true) ~= nil
  end] = function(_, _)
    return t("nil")
  end,
}

local transform = function(text, info)
  local condition_matches = function(condition, ...)
    if type(condition) == "string" then
      return condition == text
    else
      return condition(...)
    end
  end

  for condition, result in pairs(transforms) do
    if condition_matches(condition, text, info) then
      return result(text, info)
    end
  end

  return t(text)
end

local handlers = {
  parameter_list = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for idx = 0, count - 1 do
      local matching_node = node:named_child(idx)
      local type_node = matching_node:field("type")[1]
      table.insert(result, transform(vim.treesitter.get_node_text(type_node, 0), info))
      if idx ~= count - 1 then
        table.insert(result, t({ ", " }))
      end
    end

    return result
  end,

  type_identifier = function(node, info)
    local text = vim.treesitter.get_node_text(node, 0)
    return { transform(text, info) }
  end,
}

local function_node_types = {
  function_declaration = true,
  method_declaration = true,
  func_literal = true,
}

local function go_result_type(info)
  -- Get node at cursor (TreeSitter)
  local cursor_node = ts_utils.get_node_at_cursor()

  -- If no cursor, return empty
  if not cursor_node then
    return t("")
  end

  -- Find containing function
  local scope = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, v in ipairs(scope) do
    if function_node_types[v:type()] then
      function_node = v
      break
    end
  end

  -- Not inside a function, return empty
  if not function_node then
    return t("")
  end

  -- Find the return type of the function
  local query = vim.treesitter.query.parse(
    "go",
    [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
    ]]
  )

  for _, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end

  -- No return value
  return t("")
end

local go_ret_vals = function(args)
  return sn(
    nil,
    go_result_type({
      index = 0,
      err_name = args[1][1],
    })
  )
end

return {
  -- Functions
  s(
    "f",
    fmta(
      [[
      func <fname>(<args>) <ret_type><space>{
        <body>
      }
      ]],
      {
        fname = c(1, {
          i(1, "fname"),
          fmt("({} {}) {}", { i(1, "receiver"), i(2, "type"), i(3, "fname") }),
        }),
        args = i(2),
        space = n(3, " "),
        ret_type = i(3),
        body = i(4, 'panic("todo")'),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "fh",
    fmta(
      [[
      func <fname>(<res> http.ResponseWriter, <req> *http.Request) {
        <body>
      }
      ]],
      {
        fname = c(1, {
          i(1, "fname"),
          fmt("({} {}) {}", { i(1, "receiver"), i(2, "type"), i(3, "fname") }),
        }),
        res = i(2, "w"),
        req = i(3, "r"),
        body = i(4, 'panic("todo")'),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Conditionals
  s(
    "if",
    fmta(
      [[
      if <> {
        <>
      }
      ]],
      { i(1), i(2) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "ife",
    fmta(
      [[
      if <> {
        <>
      } else {
        <>
      }
      ]],
      { i(1), i(2), i(3) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "el",
    fmta(
      [[
      else {
        <>
      }
      ]],
      { i(1) }
    ),
    { condition = conds.line_begin }
  ),
  -- treesitter powered "if err"
  s(
    { trig = "ie", dscr = "if err != nil" },
    fmta(
      [[
      if <err> != nil {
        return <result>
      }
      ]],
      {
        err = i(1, "err"),
        result = d(2, go_ret_vals, { 1 }),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Loops
  s(
    "for",
    fmta(
      [[
      for <> {
        <>
      }
      ]],
      {
        c(1, {
          fmt("{} := range {}", { i(1, "item"), i(2, "collection") }),
          i(1, "condition"),
          fmt("{} := 0; {} < {}; {}++", { i(1, "i"), rep(1), i(2, "count"), rep(1) }),
        }),
        i(2),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Misc
  s(
    "pln",
    fmt("fmt.Println({})", {
      i(1),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "prf",
    fmta('fmt.Printf("<>"<comma><>)', {
      i(1, "%s"),
      comma = n(2, ", "),
      i(2),
    }),
    {
      condition = conds.line_begin,
    }
  ),
}
