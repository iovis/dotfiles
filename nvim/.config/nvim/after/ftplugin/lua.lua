local u = require("user.utils")

u.lsp_autoformat()

vim.keymap.set("n", "<leader>so", "<cmd>source %<cr>", { buffer = true })
vim.keymap.set("n", "<leader>P", ":lua =", { buffer = true })
