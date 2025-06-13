local u = require("config.utils")

u.ex.abbrev("man", "Man")

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
local function run_command(cmd)
  -- Run command
  local lines = vim.split(
    vim.api.nvim_exec2(cmd, {
      output = true,
    }).output,
    "\r?\n",
    { trimempty = true }
  )

  -- Remove the first 2 lines if it's a external command (starts with `!`)
  local is_external_command = (cmd:sub(1, 1) == "!")
  if is_external_command then
    lines = vim.list_slice(lines, 3, #lines) -- same as lines[3..]
  end

  return lines
end

u.ex.abbrev("r", "R =")
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

vim.api.nvim_create_user_command("Hitest", function()
  vim.cmd.source(vim.env.VIMRUNTIME .. "/syntax/hitest.vim")
end, {})

---- Render ANSI code colors
vim.api.nvim_create_user_command("RenderAscii", function(opts)
  local file = opts.args

  if u.is_empty(opts.args) then
    file = vim.fn.bufname()
  end

  vim.cmd("tab terminal bat -pp " .. file)

  vim.keymap.set("n", "q", "<cmd>close<cr>", {
    buffer = true,
    nowait = true,
  })
end, { nargs = "?", complete = "file" })
