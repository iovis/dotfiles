vim.keymap.set("n", "q", "gq", {
  buffer = true,
  nowait = true,
  remap = true,
})

vim.keymap.set("n", "cc", "<cmd>Git commit -v<cr>", {
  buffer = true,
})
