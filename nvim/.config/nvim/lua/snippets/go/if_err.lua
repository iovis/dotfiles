local ts_locals = require("nvim-treesitter.locals")
local ts_utils = require("nvim-treesitter.ts_utils")

local get_node_text = vim.treesitter.get_node_text

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

      return i(info.index, info.err_name)
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

local function transform(text, info)
  local function condition_matches(condition, ...)
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

      table.insert(result, transform(get_node_text(type_node, 0), info))

      if idx ~= count - 1 then
        table.insert(result, t({ ", " }))
      end
    end

    return result
  end,

  type_identifier = function(node, info)
    local text = get_node_text(node, 0)
    return { transform(text, info) }
  end,
}

local function_node_types = {
  function_declaration = true,
  method_declaration = true,
  func_literal = true,
}

local function go_result_type(info)
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, v in ipairs(scope) do
    if function_node_types[v:type()] then
      function_node = v
      break
    end
  end

  if not function_node then
    print("Not inside of a function")
    return t("")
  end

  local query = assert(vim.treesitter.query.get("go", "return-snippet"), "query missing")

  for _, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end
end

local function go_ret_vals(args)
  return sn(
    nil,
    go_result_type({
      index = 0,
      err_name = args[1][1],
    })
  )
end

return {
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
}
