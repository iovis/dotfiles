local u = require("config.utils")

u.command("REMember", [[%s/\v(\s)([-+]?\d*\.?\d*px)/\1REMember(\2)/g]], { nargs = 0 })

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
