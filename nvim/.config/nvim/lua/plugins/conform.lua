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
          "fuzzy_ls",
          "ruby_lsp",
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
        if not vim.g.autoformat then
          return
        end

        local ignore_filetypes = {}
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        return format_options
      end,
      formatters = {
        htmlbeautifier = {
          prepend_args = { "--keep-blank-lines", "1" },
        },
        sql_formatter = {
          prepend_args = { "-l", "postgresql" },
        },
      },
      formatters_by_ft = {
        ["*"] = { "injected" }, -- Treesitter based injections
        eruby = { "htmlbeautifier" },
        fish = { "fish_indent" },
        just = { "just" },
        lua = { "stylua" },
        sql = { "sql_formatter" },
        swift = { "swift_format" },
      },
    })

    -- `Format` command
    vim.keymap.set({ "n", "x" }, "<leader>b", ":Format<cr>")
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil

      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]

        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end

      conform.format(vim.tbl_deep_extend("force", format_options, { range = range }))
    end, { range = true })
  end,
}
