require("config.options")
require("config.filetype")
require("config.autocommands")
require("config.keymap")

require("config.lazy") -- load plugins

require("config.statuscol")
require("config.winbar")
require("config.statusline")
require("config.lsp")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.commands")
    require("config.diagnostics")

    pcall(require, "local")

    -- Experimental new messages UI
    if vim.g.use_ui2 then
      require("vim._core.ui2").enable({})
      vim.keymap.set("n", "<leader>M", "<cmd>messages<cr>")
      vim.keymap.set("n", "g,", "g<", {
        desc = "Show latest messages in the pager",
      })
    end
  end,
})
