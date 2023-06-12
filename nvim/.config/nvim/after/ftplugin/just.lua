vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.tabstop = 4

vim.keymap.set("n", "<leader>b", vim.lsp.buf.format, { buffer = true })
