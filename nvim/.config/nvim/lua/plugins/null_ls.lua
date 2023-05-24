return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
      debug = false,
      sources = {
        -- diagnostics.cpplint.with({ extra_args = { "--filter -legal/copyright" } }),
        diagnostics.erb_lint,
        diagnostics.fish,
        diagnostics.markdownlint.with({ extra_args = { "--disable", "MD013", "MD041" } }),
        diagnostics.ruff,
        -- diagnostics.rubocop,
        diagnostics.shellcheck,
        -- diagnostics.stylelint,
        -- diagnostics.vint,
        diagnostics.yamllint,
        diagnostics.zsh,

        formatting.erb_lint,
        formatting.fish_indent,
        formatting.prettier,
        -- formatting.rubocop,
        formatting.ruff,
        formatting.sql_formatter.with({ extra_args = { "-l", "postgresql" } }),
        -- formatting.stylelint,
        formatting.stylua,
        formatting.zigfmt,
      },
    })
  end,
}
