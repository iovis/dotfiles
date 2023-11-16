local rest = require("rest-nvim")

vim.keymap.set("n", "s<cr>", rest.run, { buffer = true })
vim.keymap.set("n", "m<cr>", "<Plug>RestNvimPreview", { buffer = true })
