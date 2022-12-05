-- Inherit from 'conf' ftplugin
vim.cmd([[runtime! ftplugin/conf.vim ftplugin/conf.lua]])

-- Restart the server
vim.keymap.set("n", "<leader>so", "<cmd>TuxBg! brew services restart skhd<cr>", { buffer = true })
