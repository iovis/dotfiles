-- EmmyLua annotations for lua-language-server:
-- https://github.com/sumneko/lua-language-server/wiki/Annotations

---- Global
--- Pretty print object
function pp(...)
  return vim.print(...)
end

----

local M = {}

M.command = function(name, fn, opts)
  vim.api.nvim_create_user_command(name, fn, opts or {})
end

M.warn = function(msg)
  vim.api.nvim_echo({ { msg, "WarningMsg" } }, true, {})
end

---Check if file exists
---@param path string
---@return boolean
M.is_file = function(path)
  return vim.fn.filereadable(vim.fn.expand(path)) == 1 or false
end

M.make_floating_window = function(custom_window_config, height_ratio, width_ratio)
  height_ratio = height_ratio or 0.8
  width_ratio = width_ratio or 0.8

  local height = math.ceil(vim.opt.lines:get() * height_ratio)
  local width = math.ceil(vim.opt.columns:get() * width_ratio)
  local window_config = {
    relative = "editor",
    style = "minimal",
    border = "double",
    width = width,
    height = height,
    row = width / 2,
    col = height / 2,
  }
  window_config = vim.tbl_extend("force", window_config, custom_window_config or {})

  local bufnr = vim.api.nvim_create_buf(false, true)
  local winnr = vim.api.nvim_open_win(bufnr, true, window_config)
  return winnr, bufnr
end

---Run system command
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
  local new_str, _ = str:gsub("_?(%l)(%w*)", function(a, b)
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

return M
