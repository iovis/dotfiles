vim.keymap.set("n", "<m-j>", "<cmd>m+<cr>", { buf = 0 })
vim.keymap.set("n", "<m-k>", "<cmd>m-2<cr>", { buf = 0 })
vim.keymap.set("x", "<m-j>", ":m'>+<cr>`<my`>mzgv`yo`z", { buf = 0, silent = true })
vim.keymap.set("x", "<m-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", { buf = 0, silent = true })
