vim.keymap.set("n", "<Space>", "<Nop>")
vim.keymap.set("n", "<leader>P", ":lua =")

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
