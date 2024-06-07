vim.keymap.set("n", "<m-j>", "<cmd>m+<cr>", { buffer = true })
vim.keymap.set("n", "<m-k>", "<cmd>m-2<cr>", { buffer = true })
vim.keymap.set("x", "<m-j>", ":m'>+<cr>`<my`>mzgv`yo`z", { buffer = true, silent = true })
vim.keymap.set("x", "<m-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", { buffer = true, silent = true })
