local M = {}

---Alias command
---Example:
---  alias_command("Grep") -- converts `:grep` to `:Grep`
---@param cmd string
function M.alias_command(cmd)
  local cmd_lowercase = cmd:lower()

  vim.keymap.set("ca", cmd_lowercase, function()
    if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == cmd_lowercase then
      return cmd
    else
      return cmd_lowercase
    end
  end, { expr = true })
end

---Define user command
---@param name string
---@param fn any
---@param opts? table<string, any>
function M.command(name, fn, opts)
  vim.api.nvim_create_user_command(name, fn, opts or {})
end

---Type the string as if it were the user typing it
---@param keys string
function M.send_keys(keys)
  local escaped_termcodes = vim.api.nvim_replace_termcodes(keys, true, false, true)

  vim.api.nvim_feedkeys(escaped_termcodes, "t", true)
end

function M.scratch(contents, opts)
  opts = opts or {}
  if opts.type == "float" then
    return M.floating_window(contents, opts)
  end

  local split_cmd = "botright "

  if opts.lines and opts.lines ~= 0 then
    split_cmd = split_cmd .. opts.lines
  end

  if not opts.type or opts.type == "horizontal" then
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

  if opts.winbar then
    local escaped_winbar = opts.winbar:gsub("%%", "%%%%") -- escape `%`
    vim.wo.winbar = ("    %%#WinbarNC#» %s"):format(escaped_winbar)
  end
end

---Is current window floating
---@return boolean
function M.is_win_floating()
  local winnr = vim.api.nvim_get_current_win()

  return vim.api.nvim_win_get_config(winnr).zindex ~= nil
end

function M.floating_window(contents, opts)
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
function M.is_file(path)
  return vim.fn.filereadable(vim.fn.expand(path)) == 1 or false
end

---Relative path to current file
---@return string
function M.current_file()
  return vim.fn.expand("%")
end

---Path to current file from Home folder
---@return string
function M.current_path()
  return vim.fn.expand("%:~")
end

---Check if there's a justfile
---@return boolean
function M.has_justfile()
  return M.is_file("justfile")
end

---Run system command synchronously
---@param cmd string[]
---@return string
function M.system(cmd)
  local result = vim.system(cmd, { text = true }):wait()

  if result.code ~= 0 then
    local stderr = vim.split(result.stderr, "\n")
    local command = vim.iter(cmd):join(" ")

    local lines = vim
      .iter({
        stderr,
        "----------------------",
        "",
        vim.split(vim.inspect(result), "\n"),
      })
      :flatten()
      :totable()

    M.scratch(lines, {
      type = "horizontal",
      lines = 8,
      winbar = command,
    })
  end

  return vim.trim(result.stdout or "")
end

---Run system command synchronously and return a list of lines
---@param cmd string[]
---@return string[]
function M.system_list(cmd)
  return vim.split(M.system(cmd), "\n", {
    trimempty = true,
  })
end

---Check if command is executable
---@param cmd string
---@return boolean
function M.is_executable(cmd)
  return vim.fn.executable(cmd) == 1
end

---- Strings
---Check if string is empty
---@param str string
---@return boolean
function M.is_empty(str)
  return vim.fn.empty(str) == 1
end

----Helper functions
--- Truncate component to `len` characters
--- @param str string
--- @param len number
--- @return string
function M.truncate(str, len)
  if #str <= len then
    return str
  end

  return str:sub(1, len - 1) .. "…"
end

---Titleizes string
---Ex: "my title" => "My Title"
---@param str string
---@return string
function M.titleize(str)
  local new_str, _ = str:gsub("(%l)(%w*)", function(a, b)
    return string.upper(a) .. b
  end)

  return new_str
end

---PascalCase string
---Ex: "my string" => "MyString"
---@param str string
---@return string
function M.pascal_case(str)
  local new_str, _ = str:gsub("%s?_?-?(%l)(%w*)", function(a, b)
    return string.upper(a) .. b
  end)

  return new_str
end

---Escape Lua pattern
---@param str string
---@return string
function M.escape_lua_pattern(str)
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

-- From: https://neovim.discourse.group/t/how-do-you-work-with-strings-with-multibyte-characters-in-lua/2437/4
function M.char_byte_count(s, i)
  if not s or s == "" then
    return 1
  end

  local char = string.byte(s, i or 1)

  -- Get byte count of unicode character (RFC 3629)
  if char > 0 and char <= 127 then
    return 1
  elseif char >= 194 and char <= 223 then
    return 2
  elseif char >= 224 and char <= 239 then
    return 3
  elseif char >= 240 and char <= 244 then
    return 4
  end
end

function M.char_on_pos(pos)
  pos = pos or vim.fn.getpos(".")
  return tostring(vim.fn.getline(pos[1])):sub(pos[2], pos[2])
end

function M.get_visual_range()
  local sr, sc = unpack(vim.fn.getpos("v"), 2, 3)
  local er, ec = unpack(vim.fn.getpos("."), 2, 3)

  -- To correct work with non-single byte chars
  local byte_c = M.char_byte_count(M.char_on_pos({ er, ec }))
  ec = ec + (byte_c - 1)

  local range = {}

  if sr == er then
    local cols = sc >= ec and { ec, sc } or { sc, ec }
    range = { sr, cols[1] - 1, er, cols[2] }
  elseif sr > er then
    range = { er, ec - 1, sr, sc }
  else
    range = { sr, sc - 1, er, ec }
  end

  return range
end

----Buffers

---Is there only one listed buffer
---@return boolean
function M.is_only_buffer()
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
function M.find_pattern_in(lines, pattern)
  for i, line in ipairs(lines) do
    if line:match(pattern) then
      return i - 1 -- nvim is 0 based
    end
  end

  if vim.g.debug then
    vim.notify(string.format("Couldn't find %s", pattern), vim.log.levels.ERROR)
  end
end

---Create an iterator from a range
---@generic T: number|string
---@param start T
---@param finish T
---@param step number?
---@return fun(): T
function M.range(start, finish, step)
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
  end

  error(("Invalid range: %s, %s, %s"):format(tostring(start), tostring(finish), tostring(step)))
end

---Treesitter utils
M.ts = {}

---Get the Treesitter root node
---@param lang? string
---@param bufnr? number
---@return TSNode
function M.ts.root_node(lang, bufnr)
  local parser = assert(vim.treesitter.get_parser(bufnr, lang))
  local tree = parser:parse()[1]

  return tree:root()
end

---Replace text in node
---@param node TSNode
---@param text string
function M.ts.replace(node, text)
  local start_row, start_col, end_row, end_col = node:range()
  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { text })
end

---Returns the first ancestor that matches one of these types
---@param node? TSNode
---@param types string[]
---@return TSNode?
function M.ts.find_ancestor(node, types)
  if not node then
    return nil
  end

  if vim.tbl_contains(types, node:type()) then
    return node
  end

  return M.ts.find_ancestor(node:parent(), types)
end

---UI
M.ui = {}

function M.ui.foldtext()
  local start = vim.fn.getline(vim.v.foldstart)
  local replace = vim.fn["repeat"](" ", vim.bo.tabstop)

  local text_start = vim.fn.substitute(start, "\\t", replace, "g")
  local text_end = vim.fn.trim(vim.fn.getline(vim.v.foldend))
  local num_lines = (vim.v.foldend - vim.v.foldstart + 1)

  return {
    { text_start, nil },
    { " ... ", "" },
    { text_end, "" },
    { ("  󰁂 %d lines"):format(num_lines), "Comment" },
  }
end

return M
