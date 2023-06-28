local u = require("config.utils")

u.command("REMember", [[%s/\v(\s)([-+]?\d*\.?\d*px)/\1REMember(\2)/g]], { nargs = 0 })

u.command("Delregisters", function(opts)
  local reg = opts.args

  if #reg == 1 then
    vim.fn.setreg(reg, "")
  else
    for i = 97, 122 do -- [a-z]
      local char = string.char(i)
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
    {}
  )

  -- Remove the first 2 lines if it's a external command (starts with `!`)
  local is_external_command = (ctx.args:sub(1, 1) == "!")
  if is_external_command then
    lines = vim.list_slice(lines, 3, #lines) -- same as lines[3..]
  end

  -- Create new scratch buffer in a split
  -- Ex: "botright 10new"
  local split_cmd = "botright "

  if ctx.count ~= 0 then
    split_cmd = split_cmd .. ctx.count
  end

  if ctx.bang then
    split_cmd = split_cmd .. "new"
  else
    split_cmd = split_cmd .. "vnew"
  end

  vim.cmd(split_cmd)

  -- Set scratch buffer properties
  vim.bo.bufhidden = "wipe"
  vim.bo.buflisted = false
  vim.bo.buftype = "nofile"
  vim.bo.filetype = "redir"

  -- Write the result to the buffer
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, { nargs = "+", complete = "command", bang = true, count = true })

---- Quick Tmux Session
u.command("Sessionist", function(opts)
  vim.fn.system(("sessionist %s"):format(opts.args))
end, { nargs = "?" })

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
