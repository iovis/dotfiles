local u = require("config.utils")

u.lsp_autoformat()

vim.keymap.set("n", "m<cr>", "<cmd>Tux clang++ %:.<cr>", { buffer = true })
vim.keymap.set("n", "s<cr>", "<cmd>Tux clang++ %:. && ./a.out<cr>", { buffer = true })
