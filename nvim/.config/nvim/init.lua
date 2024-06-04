require("config.options")
require("config.filetype")
require("config.autocommands")

require("config.lazy") -- load plugins
require("config.winbar")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.commands")
    require("config.diagnostics")
    require("config.keymap")

    -- pcall(dofile, ".nvimrc.lua")
  end,
})
