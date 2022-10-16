local ok, null_ls = pcall(require, "null-ls")
if not ok then
  print("null-ls not found!")
  return
end

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = true,
  sources = {
    diagnostics.pylint.with({
      extra_args = {
        "--disable",
        "C0301,C0114,C0115,C0116,E501,F0401",
      },
    }),
    diagnostics.shellcheck,
    diagnostics.vint,
    diagnostics.yamllint.with({ extra_args = { "-f", "parsable" } }),
    diagnostics.zsh,

    formatting.sql_formatter,
    formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
  },
})
