-- EmmyLua annotations for lua-language-server:
-- https://github.com/sumneko/lua-language-server/wiki/Annotations

local M = {}

M.command = function(name, fn, opts)
  vim.api.nvim_create_user_command(name, fn, opts or {})
end

---Check if file exists
---@param path string
---@return boolean
M.is_file = function(path)
  return vim.fn.filereadable(vim.fn.expand(path)) == 1 or false
end

---Run system command
---TODO: Remove in v0.10 `vim.system(cmd, opts):wait()`
---@param cmd string
---@param raw boolean?
---@return string
M.system = function(cmd, raw)
  local f = assert(io.popen(cmd, "r"))
  local s = assert(f:read("*a"))
  f:close()

  if raw then
    return s
  end

  s = string.gsub(s, "^%s+", "")
  s = string.gsub(s, "%s+$", "")
  s = string.gsub(s, "[\n\r]+", " ")

  return s
end

---Run system command asynchronously
---TODO: Remove in v0.10 `vim.system(cmd, opts, on_exit)`
---@param cmd string
---@param args? string[]
---@param callback? function(code: integer, signal: integer): nil
M.system_async = function(cmd, args, callback)
  local handle

  handle = vim.loop.spawn(cmd, {
    args = args,
  }, function(code, signal)
    if callback then
      callback(code, signal)
    end

    if handle then
      handle:close()
    end
  end)
end

---Check if command is executable
---@param cmd string
---@return boolean
---@return string
M.is_executable = function(cmd)
  if cmd and vim.fn.executable(cmd) == 1 then
    return true, ""
  end

  return false, string.format("command %s is not executable (make sure it's installed and on your $PATH)", cmd)
end

---- Strings
---Check if string is empty
---@param str string
---@return boolean
M.is_empty = function(str)
  return vim.fn.empty(str) == 1
end

---Titleizes string
---
---Ex: "my title" => "My Title"
---@param str string
---@return string
M.titleize = function(str)
  local new_str, _ = str:gsub("(%l)(%w*)", function(a, b)
    return string.upper(a) .. b
  end)

  return new_str
end

---PascalCase string
---
---Ex: "my string" => "MyString"
---@param str string
---@return string
M.pascal_case = function(str)
  local new_str, _ = str:gsub("%s?_?-?(%l)(%w*)", function(a, b)
    return string.upper(a) .. b
  end)

  return new_str
end

---Is there only one listed buffer
---
---@param str string
---@return string
M.escape_lua_pattern = function(str)
  local matches = {
    ["^"] = "%^",
    ["$"] = "%$",
    ["("] = "%(",
    [")"] = "%)",
    ["%"] = "%%",
    ["."] = "%.",
    ["["] = "%[",
    ["]"] = "%]",
    ["*"] = "%*",
    ["+"] = "%+",
    ["-"] = "%-",
    ["?"] = "%?",
    ["\0"] = "%z",
  }

  return (str:gsub(".", matches))
end

----Buffers

---Is there only one listed buffer
---
---@return boolean
M.is_only_buffer = function()
  local buffers = vim.api.nvim_list_bufs()
  local count = 0

  for _, buffer in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buffer) then
      count = count + 1
    end
  end

  return count == 1
end

---Find pattern in a document
---@param lines string[]
---@param pattern string
---@return number|nil line_number
M.find_pattern_in = function(lines, pattern)
  for i, line in ipairs(lines) do
    if line:match(pattern) then
      return i - 1 -- nvim is 0 based
    end
  end

  vim.notify(string.format("Couldn't find %s", pattern), vim.log.levels.ERROR)
end

---Create an iterator from a range
---@generic T: number|string
---@param start T
---@param finish T
---@param step number?
---@return fun(): T
M.range = function(start, finish, step)
  step = step or 1

  if type(start) == "number" and type(finish) == "number" then
    return coroutine.wrap(function()
      for num = start, finish, step do
        coroutine.yield(num)
      end
    end)
  elseif type(start) == "string" and type(finish) == "string" then
    return coroutine.wrap(function()
      for charCode = string.byte(start), string.byte(finish), step do
        coroutine.yield(string.char(charCode))
      end
    end)
  else
    vim.notify("Invalid range", vim.log.levels.ERROR)
  end
end

---Treesitter utils
M.ts = {}

---Get the Treesitter root node
---@param lang? string
---@param bufnr? number
---@return TSNode
M.ts.root_node = function(lang, bufnr)
  local parser = vim.treesitter.get_parser(bufnr, lang)
  local tree = parser:parse()[1]

  return tree:root()
end

---Get the Treesitter root node
---@param node TSNode
---@param text string
M.ts.replace = function(node, text)
  local start_row, start_col, end_row, end_col = node:range()
  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { text })
end

return M
