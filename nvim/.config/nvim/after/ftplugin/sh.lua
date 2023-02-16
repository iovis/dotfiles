---- yabai
if vim.fn.expand("%"):match("yabai/") then
  vim.keymap.set("n", "<leader>so", "<cmd>TuxBg! brew services restart yabai<cr>", { buffer = true })
end
