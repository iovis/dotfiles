---- yabai
if string.match(vim.fn.expand("%"), "yabai/") then
  vim.keymap.set("n", "<leader>so", "<cmd>TuxBg! brew services restart yabai<cr>", { buffer = true })
end
