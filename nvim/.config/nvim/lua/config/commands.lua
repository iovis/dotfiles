local u = require("config.utils")

u.command("Delregisters", function(opts)
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
u.command("EditFtplugin", function(opts)
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
u.command("R", function(ctx)
  -- Run command
  local lines = vim.split(
    vim.api.nvim_exec2(ctx.args, {
      output = true,
    }).output,
    "\r?\n",
    { trimempty = true }
  )

  -- Remove the first 2 lines if it's a external command (starts with `!`)
  local is_external_command = (ctx.args:sub(1, 1) == "!")
  if is_external_command then
    lines = vim.list_slice(lines, 3, #lines) -- same as lines[3..]
  end

  if vim.tbl_isempty(lines) then
    vim.notify("No output")
    return
  end

  -- Create new scratch buffer in a split
  u.scratch(lines, {
    lines = ctx.count,
    type = ctx.bang and "vertical" or "horizontal",
  })
end, { nargs = "+", complete = "command", bang = true, count = true })

u.command("P", function(ctx)
  -- Run command
  local lines = vim.split(
    vim.api.nvim_exec2(ctx.args, {
      output = true,
    }).output,
    "\r?\n",
    { trimempty = true }
  )

  -- Remove the first 2 lines if it's a external command (starts with `!`)
  local is_external_command = (ctx.args:sub(1, 1) == "!")
  if is_external_command then
    lines = vim.list_slice(lines, 3, #lines) -- same as lines[3..]
  end

  if vim.tbl_isempty(lines) then
    vim.notify("No output")
    return
  end

  -- Create new scratch buffer in a floating window
  u.scratch(lines, { type = "float" })
end, { nargs = "+", complete = "command" })

---- Quick open vim plugin in new window
u.command("VimPlugin", function(opts)
  local plugins_path = vim.fn.stdpath("data") .. "/lazy/"

  local command = string.format(
    [[fd -td -d1 --base-directory %s | fzf-tmux -p60%%,60%% --select-1 --exit-0 --reverse --info inline --prompt "plugin> "]],
    plugins_path
  )

  -- Add query if provided
  if not u.is_empty(opts.args) then
    command = command .. string.format([[ --query="%s"]], opts.args)
  end

  local plugin = vim.trim(vim.fn.system(command))
  if u.is_empty(plugin) then
    return
  end

  local directory = ("%s/%s"):format(plugins_path, plugin)

  local cmd = string.format([[tmux new-window -c "%s"]], directory)

  vim.fn.system(cmd)
end, { nargs = "?" })

---- Force OSC52
-- TODO: Not working?
u.command("ForceOSC52", function()
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }

  vim.notify("OSC52 enabled")
end)
