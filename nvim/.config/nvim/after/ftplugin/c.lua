---- runnables
if vim.fn.expand("%"):match("ext/") then
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- rake compile<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux just run<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux just build<cr>", { buffer = true })
end
