return {
  "j-hui/fidget.nvim",
  event = "VeryLazy",
  config = function()
    ---@param msg ProgressMessage
    ---@return string?
    local lsp_format_message = function(msg)
      -- Ignore "Diagnosing..." progress messages
      if string.find(msg.title, "Diagnosing") then
        return nil
      end

      local message = msg.message

      if not message then
        message = msg.done and "Completed" or "In progress..."
      end

      if msg.percentage ~= nil then
        message = string.format("%s (%.0f%%)", message, msg.percentage)
      end

      return message
    end

    local fidget = require("fidget")
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
          rspec = vim.tbl_extend("force", fidget.notification.default_config, {
            name = "RSpec",
            icon = fidget.progress.display.for_icon(fidget.spinner.animate("dots", 1), "✔"),
            icon_style = "Title",
          }),
        },
        window = {
          winblend = 0,
        },
      },
    })
  end,
}
