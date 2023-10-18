local rest = require("rest-nvim")

vim.keymap.set("n", "s<cr>", rest.run, { buffer = true })
vim.keymap.set("n", "c<cr>", "<Plug>RestNvimPreview", { buffer = true })
