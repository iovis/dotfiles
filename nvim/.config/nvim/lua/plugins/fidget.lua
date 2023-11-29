return {
  "j-hui/fidget.nvim",
  event = "VeryLazy",
  config = function()
    local fidget = require("fidget")

    ---@param msg ProgressMessage
    ---@return string?
    local lsp_format_message = function(msg)
      -- Ignore "Diagnosing..." progress messages
      if msg.title and string.find(msg.title, "Diagnosing") then
        return nil
      end

      return fidget.progress.display.default_format_message(msg)
    end

    fidget.setup({
      progress = { -- LSP
        ignore = { "null-ls" },
        display = {
          format_message = lsp_format_message,
        },
      },
      notification = {
        configs = {
          default = fidget.notification.default_config,
          dependencies = vim.tbl_extend("force", fidget.notification.default_config, {
            name = "dependencies",
            icon = fidget.progress.display.for_icon(fidget.spinner.animate("dots", 1), "✔"),
            icon_style = "Title",
          }),
          rspec = vim.tbl_extend("force", fidget.notification.default_config, {
            name = "RSpec",
            icon = fidget.progress.display.for_icon(fidget.spinner.animate("dots", 1), "✔"),
            icon_style = "Title",
          }),
        },
        view = {
          group_separator = "",
        },
        window = {
          winblend = 0,
        },
      },
    })
  end,
}
