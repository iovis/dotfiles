local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

-- NOTE: Formatting conflicts
-----------------------------
-- If when formatting there are multiple possible candidates for
-- formatting, Neovim will ask you which one to use. If you want to use
-- null-ls formatting you can disable the conflicting language's
-- formatting capabilities.
-- See: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts

-- local completion = null_ls.builtins.completion
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = true,
  sources = {
    -- Doesn't seem to work
    -- completion.tags.with({
    --   filetypes = { "ruby" },
    -- }),

    -- diagnostics.eslint,
    diagnostics.jsonlint,
    diagnostics.pylint.with({
      extra_args = {
        "--disable",
        "C0301,C0114,C0115,C0116,E501,F0401",
      },
    }),
    diagnostics.rubocop,
    diagnostics.shellcheck,
    diagnostics.vint,
    diagnostics.yamllint.with({ extra_args = { "-f", "parsable" } }),
    diagnostics.zsh,

    -- formatting.eslint,
    formatting.rubocop,
    formatting.sqlformat.with({ extra_args = { "-rs" } }),
    formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
  },
})
