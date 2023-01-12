---- skhd
if string.match(vim.fn.expand("%"), "skhd/") then
  vim.keymap.set("n", "<leader>so", "<cmd>TuxBg! brew services restart skhd<cr>", { buffer = true })
end
