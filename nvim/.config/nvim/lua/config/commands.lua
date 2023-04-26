local u = require("config.utils")

---- Quick FtPlugin
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
    {}
  )

  -- Remove the first 2 lines if it's a external command (starts with `!`)
  local is_external_command = (ctx.args:sub(1, 1) == "!")
  if is_external_command then
    lines = vim.list_slice(lines, 3, #lines) -- same as lines[3..]
  end

  -- Create new scratch buffer in a split
  if ctx.bang then
    vim.cmd("botright 10new")
  else
    vim.cmd("botright vnew")
  end

  vim.bo.bufhidden = "wipe"
  vim.bo.buflisted = false
  vim.bo.buftype = "nofile"
  vim.bo.filetype = "redir"

  -- Write the result to the buffer
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, { nargs = "+", complete = "command", bang = true })

---- Quick Tmux Session
u.command("TmuxNewSession", function(opts)
  local command = [[fd -td --max-depth 2 . $HOME/Sites | fzf-tmux -p80%,80% --select-1 --exit-0 --reverse ]]

  -- Add query if provided
  if not u.is_empty(opts.args) then
    command = command .. string.format([[ --query="%s"]], opts.args)
  end

  local directory = vim.trim(vim.fn.system(command))

  if u.is_empty(directory) then
    print(string.format("directory %s not found", opts.args))
    return
  end

  -- Extract session name from last folder
  local session_name = vim.fn.fnamemodify(directory, ":h:t")

  local cmd = string.format(
    [[tmux has-session -t "%s" || tmux new-session -d -s "%s" -c "%s" && tmux switch-client -t "%s"]],
    session_name,
    session_name,
    directory,
    session_name
  )

  vim.fn.system(cmd)
end, { nargs = "?" })

---- Quick open vim plugin in new window
u.command("VimPlugin", function(opts)
  local plugins_path = vim.fn.stdpath("data") .. "/lazy/"

  local command =
    string.format([[fd -td --max-depth 1 . %s | fzf-tmux -p80%%,80%% --select-1 --exit-0 --reverse]], plugins_path)

  -- Add query if provided
  if not u.is_empty(opts.args) then
    command = command .. string.format([[ --query="%s"]], opts.args)
  end

  local directory = vim.trim(vim.fn.system(command))

  if u.is_empty(directory) then
    print(string.format("directory %s not found", opts.args))
    return
  end

  local cmd = string.format([[tmux new-window -c "%s"]], directory)

  vim.fn.system(cmd)
end, { nargs = "?" })

u.command("REMember", [[%s/\v(\s)([-+]?\d*\.?\d*px)/\1REMember(\2)/g]], { nargs = 0 })

----Reload Highlights
-- u.command("ReloadHighlights", function()
--   -- Not sure why I have to reload the package for the function to run
--   package.loaded["config.highlights"] = nil
--   require("config.highlights").custom_highlights()
-- end)
--
-- u.command("ReloadPlugins", function()
--   for name, _ in pairs(package.loaded) do
--     if name:match("^plugins") then
--       package.loaded[name] = nil
--       require(name)
--     end
--   end
-- end)
