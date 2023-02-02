vim.keymap.set("n", "<leader>so", function()
  vim.cmd("silent !tmux source % && tmux display 'Tmux reloaded!'")
end, { buffer = true, desc = "Reload Tmux" })
