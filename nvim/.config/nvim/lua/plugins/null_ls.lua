local M = {
  "jose-elias-alvarez/null-ls.nvim",
}

function M.config()
  local ok, null_ls = pcall(require, "null-ls")
  if not ok then
    print("null-ls not found!")
    return
  end

  local diagnostics = null_ls.builtins.diagnostics
  local formatting = null_ls.builtins.formatting

  null_ls.setup({
    debug = false,
    on_attach = function()
      vim.keymap.set({ "n", "x" }, "<leader>b", function()
        vim.lsp.buf.format({ timeout_ms = 2000 })
      end, { buffer = true, desc = "vim.lsp.buf.format" })
    end,
    sources = {
      diagnostics.codespell.with({
        filetypes = { "ruby" },
      }),
      diagnostics.pylint.with({
        extra_args = {
          "--disable",
          "C0301,C0114,C0115,C0116,E501,F0401",
        },
      }),
      diagnostics.rubocop,
      diagnostics.erb_lint,
      diagnostics.shellcheck,
      diagnostics.vint,
      diagnostics.yamllint.with({ extra_args = { "-f", "parsable", "--no-warnings" } }),
      diagnostics.zsh,

      formatting.rubocop,
      formatting.erb_lint,
      formatting.sql_formatter.with({ extra_args = { "-l", "postgresql" } }),
      formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
    },
  })
end

return M
