vim.keymap.set("n", "s<cr>", "<cmd>Tux numbat %:.<cr>", { buf = 0 })
vim.keymap.set("n", "d<cr>", function()
  vim.ui.open("https://numbat.dev/doc/")
end, { buf = 0 })
