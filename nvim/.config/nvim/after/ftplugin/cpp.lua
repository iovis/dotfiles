vim.keymap.set("n", "s<cr>", "<cmd>Tux just run<cr>", { buffer = true })
vim.keymap.set("n", "m<cr>", "<cmd>Tux just build<cr>", { buffer = true })

vim.keymap.set("n", "<leader>aa", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = true })
