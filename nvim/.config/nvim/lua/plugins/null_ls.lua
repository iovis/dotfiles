return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
      debug = false,
      sources = {
        diagnostics.codespell.with({ filetypes = { "ruby" } }),
        -- diagnostics.cpplint.with({ extra_args = { "--filter -legal/copyright" } }),
        diagnostics.erb_lint,
        diagnostics.fish,
        diagnostics.pylint.with({ extra_args = { "--disable", "C0301,C0114,C0115,C0116,E501,F0401" } }),
        -- diagnostics.rubocop,
        diagnostics.shellcheck,
        -- diagnostics.stylelint,
        diagnostics.vint,
        diagnostics.yamllint,
        diagnostics.zsh,

        formatting.erb_lint,
        formatting.fish_indent,
        formatting.prettier,
        -- formatting.rubocop,
        formatting.sql_formatter.with({ extra_args = { "-l", "postgresql" } }),
        -- formatting.stylelint,
        formatting.stylua,
        formatting.zigfmt,
      },
    })
  end,
}
