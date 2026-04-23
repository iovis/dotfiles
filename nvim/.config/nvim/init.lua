require("config.options")
require("config.filetype")
require("config.autocommands")
require("config.keymap")

require("config.lazy") -- load plugins

require("config.ui.statuscol")
require("config.ui.tabline")
require("config.ui.winbar")
require("config.ui.statusline")
require("config.lsp")

-- Experimental new messages UI
require("vim._core.ui2").enable({})
vim.keymap.set("n", "<leader>M", "<cmd>messages<cr>")
vim.keymap.set("n", "g,", "g<", {
  desc = "Show latest messages in the pager",
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.commands")
    require("config.diagnostics")

    pcall(require, "local")
  end,
})
