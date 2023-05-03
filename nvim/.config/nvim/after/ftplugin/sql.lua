vim.keymap.set("n", "s<cr>", "mzvip:DB<cr>`z", { buffer = true })
vim.keymap.set("x", "s<cr>", ":DB<cr>", { buffer = true })

vim.keymap.set("n", "<leader>b", vim.lsp.buf.format, { buffer = true })
