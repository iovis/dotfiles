---- yabai
if vim.fn.expand("%"):match("yabai/") then
  vim.keymap.set("n", "<leader>so", "<cmd>TuxBg! yabai --restart-service<cr>", { buffer = true })
end
