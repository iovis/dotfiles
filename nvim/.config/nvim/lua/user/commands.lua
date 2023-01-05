local u = require("user.utils")

vim.keymap.set("n", "++", "<cmd>TmuxNewSession<cr>")
vim.keymap.set("n", "+<space>", ":TmuxNewSession<space>")
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

-- u.command("ReloadPlugins", function()
--   for name, _ in pairs(package.loaded) do
--     if name:match("^plugins") then
--       package.loaded[name] = nil
--       require(name)
--     end
--   end
-- end)
