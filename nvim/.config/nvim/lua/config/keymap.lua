vim.keymap.set("n", "<Space>", "<Nop>")
vim.keymap.set("n", "<leader>P", ":lua=")

---- Tmux quick switching
vim.keymap.set("n", "++", "<cmd>TmuxNewSession<cr>")
vim.keymap.set("n", "+<space>", ":TmuxNewSession<space>")
vim.keymap.set("n", "+V", "<cmd>VimPlugin<cr>")

---- Toggle autoformat
vim.g.autoformat = true
vim.keymap.set("n", "<leader>B", function()
  if vim.g.autoformat then
    vim.g.autoformat = false
    print("Autoformat disabled")
  else
    vim.g.autoformat = true
    print("Autoformat enabled")
  end
end, { desc = "Toggle autoformat" })
