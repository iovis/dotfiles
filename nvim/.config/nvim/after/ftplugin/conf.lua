---- skhd
if vim.fn.expand("%"):match("skhd/") then
  vim.keymap.set("n", "<leader>so", "<cmd>TuxBg! skhd --restart-service<cr>", { buffer = true })
end
