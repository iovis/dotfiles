---- runnables
if vim.fn.expand("%"):match("ext/") then
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- rake compile<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bear -- just run<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- just build<cr>", { buffer = true })
end

vim.keymap.set("n", "<leader>aa", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = true })
