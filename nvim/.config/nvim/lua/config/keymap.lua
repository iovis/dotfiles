vim.keymap.set("n", "<Space>", "<Nop>")

vim.keymap.set("n", "<leader>P", ":lua=")
vim.keymap.set("n", "+t", "<c-w>T")
vim.keymap.set("n", "<leader>uf", "<cmd>EditFtplugin<cr>")

---- Global substitutions
vim.keymap.set({ "n", "x" }, "+g", ":g//<left>")
vim.keymap.set({ "n", "x" }, "+l", ':luado return string.format("%s", line)')
vim.keymap.set({ "n", "x" }, "+v", ":v//<left>")

---- Tmux quick switching
vim.keymap.set("n", "++", "<cmd>TmuxNewSession<cr>")
vim.keymap.set("n", "+<space>", ":TmuxNewSession<space>")
vim.keymap.set("n", "+V", "<cmd>VimPlugin<cr>")

---- Toggle autoformat
vim.keymap.set("n", "<leader>B", function()
  if vim.g.autoformat then
    vim.g.autoformat = false
    print("Autoformat disabled")
  else
    vim.g.autoformat = true
    print("Autoformat enabled")
  end
end, { desc = "Toggle autoformat" })

---- Toggle autotest
vim.keymap.set("n", "+T", function()
  if vim.g.autotest then
    vim.g.autotest = false
    print("Autotest disabled")
  else
    vim.g.autotest = true
    print("Autotest enabled")
  end
end, { desc = "Toggle autotest" })
