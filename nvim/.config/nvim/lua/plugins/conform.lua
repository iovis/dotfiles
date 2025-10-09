return {
  "stevearc/conform.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    local format_options = {
      timeout_ms = 2000,
      lsp_format = "fallback",
    }

    local conform = require("conform")
    conform.setup({
      log_level = vim.log.levels.ERROR,
      format_on_save = function(bufnr)
        local ignore_filetypes = {}

        if not vim.g.autoformat or vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        -- Disable autoformat for files in a certain path
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
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
        -- eruby = { "htmlbeautifier" },
        hurl = { "hurlfmt" },
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback" },
        sql = { "sql_formatter" },
        swift = { "swift_format" },
      },
    })

    -- `Format` command
    vim.keymap.set({ "n", "x" }, "<leader>fo", ":Format<cr>")
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil

      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]

        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end

      require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })
  end,
}
