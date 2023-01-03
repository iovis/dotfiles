vim.filetype.add({
  extension = {
    tmux = "tmux",
  },
  filename = {
    ["skhdrc"] = "skhd",
  },
})

---- Quick FtPlugin
local u = require("user.utils")

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
  local path = "$HOME/.config/nvim/after/ftplugin/" .. filetype

  if u.is_file(path .. ".vim") then
    vim.cmd("keepjumps e! " .. path .. ".vim")
  else
    vim.cmd("keepjumps e! " .. path .. ".lua")
  end
end

u.command("EditFtplugin", edit_ft_plugin, { nargs = "?", complete = "filetype" })
vim.keymap.set("n", "<leader>uf", "<cmd>EditFtplugin<cr>")
