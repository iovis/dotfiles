vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.formatoptions = "toqrn1j"
vim.opt_local.comments:append({ "b:-", "b:*" })

vim.keymap.set("n", "q", "<cmd>wq<cr>", { buf = 0, nowait = true, silent = true })
vim.keymap.set("i", "<c-h>", "<esc><cmd>Glg -500<cr><c-w><c-w>a", { buf = 0, silent = true })
