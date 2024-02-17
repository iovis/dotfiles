return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  config = function()
    require("conform").setup({
      log_level = vim.log.levels.ERROR,
      format_on_save = function(_bufnr)
        if not vim.g.autoformat then
          return
        end

        return {
          timeout_ms = 2000,
          lsp_fallback = "always",
          filter = function(client)
            local dont_format_with = {
              "fuzzy_ls",
              "ruby_ls",
              "solargraph",
              "tsserver",
            }

            return not vim.tbl_contains(dont_format_with, client.name)
          end,
        }
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
        lua = { "stylua" },
        sql = { "sql_formatter" },
        swift = { "swift_format" },
      },
    })
  end,
}
