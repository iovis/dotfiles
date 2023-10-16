return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
      -- debug = true,
      sources = {
        -- diagnostics.cpplint.with({ extra_args = { "--filter -legal/copyright" } }),
        diagnostics.erb_lint,
        diagnostics.fish,
        diagnostics.markdownlint.with({ extra_args = { "--disable", "MD013", "MD022", "MD034", "MD041" } }),
        diagnostics.ruff,
        -- diagnostics.rubocop, -- Disable with nvim v0.10 because ruby-lsp uses pull diagnostics (https://github.com/Shopify/ruby-lsp/blob/main/EDITORS.md#Neovim-LSP)
        diagnostics.shellcheck,
        -- diagnostics.stylelint,
        -- diagnostics.vint,
        diagnostics.yamllint,
        diagnostics.zsh,

        formatting.erb_lint,
        formatting.fish_indent,
        formatting.just,
        formatting.prettier,
        -- formatting.rubocop,
        formatting.ruff,
        formatting.sql_formatter.with({ extra_args = { "-l", "postgresql" } }),
        -- formatting.stylelint,
        formatting.stylua,
      },
      on_attach = function()
        vim.keymap.set({ "n", "x" }, "<leader>b", vim.lsp.buf.format, { buffer = true, desc = "vim.lsp.buf.format" })
      end,
    })
  end,
}
