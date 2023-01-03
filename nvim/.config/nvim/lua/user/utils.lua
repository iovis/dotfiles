-- Annotations for lua-language-server:
-- https://github.com/sumneko/lua-language-server/wiki/Annotations

---- Global
--- Pretty print object
function pp(...)
  return vim.pretty_print(...)
end

----

local M = {}

--- Create highlight groups
---
--- hi.Comment = { fg="#ffffff", bg="#000000" }
--- hi.LspDiagnosticsDefaultError = 'DiagnosticError' -- Link to another group
M.hi = setmetatable({}, {
  ---@param hlgroup string
  ---@param args string|table
  __newindex = function(_, hlgroup, args)
    -- Link highlight group
    if "string" == type(args) then
      vim.api.nvim_set_hl(0, hlgroup, { link = args })
      return
    end

    vim.api.nvim_set_hl(0, hlgroup, args)
  end,
})

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

M.lsp_autoformat = function()
  local group = vim.api.nvim_create_augroup("lsp_document_format", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    buffer = 0,
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
    desc = "Autoformat with LSP on save",
  })
end

return M
