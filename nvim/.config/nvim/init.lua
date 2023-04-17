vim.g.mapleader = " "

require("config.filetype")
require("config.lazy") -- load plugins

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config")
  end,
})
