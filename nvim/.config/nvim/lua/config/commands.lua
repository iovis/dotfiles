local u = require("config.utils")

u.ex.abbrev("m", "Man")
u.ex.abbrev("st", "vert bo terminal")
u.ex.abbrev("t", "terminal")
u.ex.abbrev("ve", "vert bo")
u.ex.abbrev("vh", "vert bo h")

vim.api.nvim_create_user_command("Hitest", function()
  vim.cmd.source(vim.env.VIMRUNTIME .. "/syntax/hitest.vim")
end, {})

vim.api.nvim_create_user_command("Delregisters", function(opts)
  local reg = opts.args

  if #reg == 1 then
    vim.fn.setreg(reg, "")
  else
    for char in u.range("a", "z") do
      vim.fn.setreg(char, "")
    end
  end
end, { nargs = "?" })

---- Quick Ftplugin
vim.api.nvim_create_user_command("EditFtplugin", function(opts)
  -- Filetype detection
  local filetype = opts.args

  if u.is_empty(opts.args) then
    filetype = vim.bo.filetype
  end

  if u.is_empty(filetype) then
    print("no filetype specified")
    return
  end

  -- Open {filetype}.vim or {filetype}.lua
  local path = string.format("$HOME/.config/nvim/after/ftplugin/%s", filetype)
  local open_cmd = string.format("keepjumps e! %s", path)

  if u.is_file(path .. ".vim") then
    vim.cmd(open_cmd .. ".vim")
  else
    vim.cmd(open_cmd .. ".lua")
  end
end, { nargs = "?", complete = "filetype" })

---- Redir
local function split_output(output)
  output = output:gsub("\r\n", "\n"):gsub("\r", "\n")

  local lines = vim.split(output, "\n", { plain = true })
  if lines[#lines] == "" then
    table.remove(lines)
  end

  return lines
end

local function run_shell_escape(cmd)
  local shell_cmd = vim.trim(cmd:sub(2))
  if shell_cmd == "" then
    return {}
  end

  local lines = split_output(vim.fn.system(shell_cmd))
  if vim.v.shell_error ~= 0 then
    vim.notify(("Command exited with %d"):format(vim.v.shell_error), vim.log.levels.WARN)
  end

  return lines
end

local function run_ex_command(cmd)
  return split_output(vim.api.nvim_exec2(cmd, { output = true }).output)
end

local function run_command(cmd)
  if cmd:sub(1, 1) == "!" then
    return run_shell_escape(cmd)
  end

  return run_ex_command(cmd)
end

vim.api.nvim_create_user_command("R", function(ctx)
  local lines = run_command(ctx.args)
  if vim.tbl_isempty(lines) then
    vim.notify("No output")
    return
  end

  u.scratch(lines, {
    lines = ctx.count,
    type = ctx.bang and "vertical" or "horizontal",
    winbar = ctx.args,
  })
end, { nargs = "+", complete = "command", bang = true, count = true })

vim.api.nvim_create_user_command("P", function(ctx)
  local lines = run_command(ctx.args)
  if vim.tbl_isempty(lines) then
    vim.notify("No output")
    return
  end

  u.scratch(lines, { type = "float" })
end, { nargs = "+", complete = "command" })

---- Terminal
-- Render ANSI color codes in current buffer
vim.api.nvim_create_user_command("RenderAscii", function()
  vim.api.nvim_open_term(0, {})

  vim.cmd.stopinsert()

  vim.keymap.set("n", "q", "<cmd>quit<cr>", {
    buf = 0,
    nowait = true,
  })
end, {})
