---- Global
-- Pretty print object
function _G.pp(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end
----

local M = {}

M.highlight = function(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

M.command = function(name, fn, opts)
  vim.api.nvim_create_user_command(name, fn, opts or {})
end

M.warn = function(msg)
  vim.api.nvim_echo({ { msg, "WarningMsg" } }, true, {})
end

M.is_file = function(path)
  if path == "" then
    return false
  end

  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file"
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

M.is_executable = function(cmd)
  if cmd and vim.fn.executable(cmd) == 1 then
    return true
  end

  return false, string.format("command %s is not executable (make sure it's installed and on your $PATH)", cmd)
end

M.has_value = function(value, table)
  for _, val in ipairs(table) do
    if value == val then
      return true
    end
  end

  return false
end

---- Strings
M.is_empty = function(str)
  return str == nil or str == ""
end

M.titleize = function(str)
  -- my title => My Title
  return str:gsub("(%l)(%w*)", function(a, b)
    return string.upper(a) .. b
  end)
end

M.pascal_case = function(str)
  return str:gsub("_?(%l)(%w*)", function(a, b)
    return string.upper(a) .. b
  end)
end

return M
