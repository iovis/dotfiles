return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>lc", "<cmd>ConformInfo<cr>" },
  },
  config = function()
    local format_options = {
      timeout_ms = 2000,
      lsp_fallback = "always",
      filter = function(client)
        local dont_format_with = {
          "html",
          "fuzzy_ls",
          "ruby_ls",
          "solargraph",
          "tsserver",
        }

        return not vim.tbl_contains(dont_format_with, client.name)
      end,
    }

    local conform = require("conform")
    conform.setup({
      log_level = vim.log.levels.ERROR,
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if not vim.g.autoformat or ft == "eruby" then
          return
        end

        return format_options
      end,
      formatters = {
        sql_formatter = {
          prepend_args = { "-l", "postgresql" },
        },
      },
      formatters_by_ft = {
        ["*"] = { "injected" }, -- Treesitter based injections
        fish = { "fish_indent" },
        just = { "just" },
        eruby = { "erb_format" },
        lua = { "stylua" },
        sql = { "sql_formatter" },
        swift = { "swift_format" },
      },
    })

    vim.keymap.set("n", "<leader>b", function()
      conform.format(format_options)
    end, { desc = "Format with conform.nvim" })
  end,
}
