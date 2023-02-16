---- skhd
if vim.fn.expand("%"):match("skhd/") then
  vim.keymap.set("n", "<leader>so", "<cmd>TuxBg! brew services restart skhd<cr>", { buffer = true })
end
