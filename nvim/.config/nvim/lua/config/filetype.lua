vim.filetype.add({
  extension = {
    tmux = "tmux",
  },
  filename = {
    ["pryrc"] = "ruby",
  },
})

---- Quick FtPlugin
local u = require("config.utils")

local edit_ft_plugin = function(opts)
  ---- Filetype detection
  local filetype = opts.args

  if u.is_empty(opts.args) then
    filetype = vim.bo.filetype
  end

  if u.is_empty(filetype) then
    print("no filetype specified")
    return
  end

  ---- Open {filetype}.vim or {filetype}.lua
  local path = string.format("$HOME/.config/nvim/after/ftplugin/%s", filetype)
  local open_cmd = string.format("keepjumps e! %s", path)

  if u.is_file(path .. ".vim") then
    vim.cmd(open_cmd .. ".vim")
  else
    vim.cmd(open_cmd .. ".lua")
  end
end

u.command("EditFtplugin", edit_ft_plugin, { nargs = "?", complete = "filetype" })
vim.keymap.set("n", "<leader>uf", "<cmd>EditFtplugin<cr>")
