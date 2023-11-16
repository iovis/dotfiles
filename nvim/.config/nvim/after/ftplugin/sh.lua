vim.keymap.set("n", "s<cr>", "<cmd>Tux %<cr>", { buffer = true })
vim.keymap.set("n", "m<cr>", "<cmd>!chmod +x %<cr>", { buffer = true })

---- yabai
if vim.fn.expand("%"):match("yabai/") then
  vim.keymap.set("n", "s<cr>", "<cmd>TuxBg! yabai --restart-service<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>so", "<cmd>TuxBg! yabai --restart-service<cr>", { buffer = true })
end
