return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
      debug = false,
      sources = {
        diagnostics.erb_lint,
        diagnostics.fish,
        diagnostics.shellcheck,
        diagnostics.stylelint,
        diagnostics.yamllint,

        formatting.erb_lint,
        formatting.fish_indent,
        formatting.just,
        formatting.sql_formatter.with({ extra_args = { "-l", "postgresql" } }),
        formatting.stylelint,
        formatting.stylua,
      },
      on_attach = function()
        vim.keymap.set({ "n", "x" }, "<leader>b", vim.lsp.buf.format, {
          buffer = true,
          desc = "vim.lsp.buf.format",
        })
      end,
    })
  end,
}
