-- EmmyLua annotations for lua-language-server:
-- https://github.com/sumneko/lua-language-server/wiki/Annotations

local M = {}

---Alias command
---@param cmd string
M.cabbrev = function(cmd)
  -- TODO: There may be a `vim.keymap.set("ca", ...)` in nvim v0.10
  -- cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep'
  local vim_cmd = ([[
    cnoreabbrev <expr> %s (getcmdtype() ==# ':' && getcmdline() ==# '%s') ? '%s' : '%s'
  ]]):format(cmd:lower(), cmd:lower(), cmd, cmd:lower())

  vim.cmd(vim_cmd)
end

---Define user command
---@param name string
---@param fn any
---@param opts? table<string, any>
M.command = function(name, fn, opts)
  vim.api.nvim_create_user_command(name, fn, opts or {})
end

---Type the string as if it were the user typing it
---@param keys string
M.send_keys = function(keys)
  local escaped_termcodes = vim.api.nvim_replace_termcodes(keys, true, false, true)

  vim.api.nvim_feedkeys(escaped_termcodes, "t", true)
end

M.scratch = function(contents, opts)
  if opts.type == "float" then
    return M.floating_window(contents, opts)
  end

  local split_cmd = "botright "

  if opts.lines ~= 0 then
    split_cmd = split_cmd .. opts.lines
  end

  if opts.type == "horizontal" then
    split_cmd = split_cmd .. "new"
  elseif opts.type == "vertical" then
    split_cmd = split_cmd .. "vnew"
  else
    vim.notify("Unknown option: " .. opts.type, vim.log.levels.ERROR)
    return
  end

  vim.cmd(split_cmd)

  vim.bo.bufhidden = "wipe"
  vim.bo.buflisted = false
  vim.bo.buftype = "nofile"
  vim.bo.filetype = "redir"

  vim.api.nvim_buf_set_lines(0, 0, -1, false, contents)
  vim.bo.filetype = opts.filetype or "lua"
end

M.floating_window = function(contents, opts)
  local win_opts = vim.tbl_extend("force", {
    title = nil,
    filetype = "lua",
    width = 0.66,
    height = 0.5,
  }, opts or {})

  local bufnr = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * win_opts.width)
  local height = math.floor(vim.o.lines * win_opts.height)

  vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor(vim.o.columns / 2 - width / 2 - 3),
    row = math.floor(vim.o.lines / 2 - height / 2 - 2),
    style = "minimal",
    border = "rounded",
    title = win_opts.title,
    noautocmd = true,
  })

  -- Set the contents to muxi table and the filetype to lua
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
  vim.bo[bufnr].filetype = win_opts.filetype

  -- Map [q] to read the changes and close the popup
  vim.keymap.set("n", "q", "<cmd>close<cr>", {
    buffer = bufnr,
    nowait = true,
  })
end

---Check if file exists
---@param path string
---@return boolean
M.is_file = function(path)
  return vim.fn.filereadable(vim.fn.expand(path)) == 1 or false
end

---Check if there's a justfile
---@return boolean
M.has_justfile = function()
  return M.is_file("justfile")
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

  handle = vim.uv.spawn(cmd, {
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

----Helper functions
--- Truncate component to `len` characters
--- @param str string
--- @param len number
--- @return string
M.truncate = function(str, len)
  if #str <= len then
    return str
  end

  return str:sub(1, len - 1) .. "…"
end

---Titleizes string
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
---Ex: "my string" => "MyString"
---@param str string
---@return string
M.pascal_case = function(str)
  local new_str, _ = str:gsub("%s?_?-?(%l)(%w*)", function(a, b)
    return string.upper(a) .. b
  end)

  return new_str
end

---Escape Lua pattern
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
