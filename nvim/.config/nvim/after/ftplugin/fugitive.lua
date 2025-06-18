vim.keymap.set("n", "q", "gq", {
  buffer = true,
  nowait = true,
  remap = true,
})

-- open in splits
vim.keymap.set("n", "<c-s>", "o", {
  buffer = true,
  remap = true,
})

vim.keymap.set("n", "<c-v>", "gO", {
  buffer = true,
  remap = true,
})

vim.keymap.set("n", "<c-t>", "O", {
  buffer = true,
  remap = true,
})
