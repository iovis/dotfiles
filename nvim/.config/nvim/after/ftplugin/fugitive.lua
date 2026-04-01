vim.keymap.set("n", "q", "gq", {
  buf = 0,
  nowait = true,
  remap = true,
})

-- open in splits
vim.keymap.set("n", "<c-s>", "o", {
  buf = 0,
  remap = true,
})

vim.keymap.set("n", "<c-v>", "gO", {
  buf = 0,
  remap = true,
})

vim.keymap.set("n", "<c-t>", "O", {
  buf = 0,
  remap = true,
})
