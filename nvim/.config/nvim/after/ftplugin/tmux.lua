vim.keymap.set("n", "<leader>so", function()
  vim.cmd("silent !tmux source %")
  vim.cmd("silent !tmux display 'sourced %:.'")
end, { buf = 0, desc = "Reload Tmux" })
