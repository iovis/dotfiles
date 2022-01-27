local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local completion = null_ls.builtins.completion
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = true,
  sources = {
    -- diagnostics.eslint,
    diagnostics.jsonlint,
    diagnostics.pylint.with({ extra_args = { "--disable", "C0301,C0114,C0115,C0116,E501" } }),
    diagnostics.rubocop,
    diagnostics.shellcheck,
    diagnostics.vint,
    diagnostics.yamllint.with({ extra_args = { "-f", "parsable" } }),

    -- formatting.eslint,
    formatting.rubocop,
    formatting.sqlformat,
    formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
  },
})
