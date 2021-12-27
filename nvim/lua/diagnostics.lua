local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn",  text = "" },
  { name = "DiagnosticSignHint",  text = "" },
  { name = "DiagnosticSignInfo",  text = "" },
}

vim.cmd([[
  hi DiagnosticSignError ctermfg=1 ctermbg=18 guifg=#ab4642 guibg=#282828
  hi DiagnosticSignWarn  ctermfg=3 ctermbg=18 guifg=#f7ca88 guibg=#282828
  hi DiagnosticSignInfo  ctermfg=4 ctermbg=18 guifg=#7cafc2 guibg=#282828
  hi DiagnosticSignHint  ctermfg=4 ctermbg=18 guifg=#7cafc2 guibg=#282828

  hi DiagnosticVirtualTextError ctermfg=1 guifg=#ab4642
  hi DiagnosticVirtualTextWarn  ctermfg=3 guifg=#f7ca88
  hi DiagnosticVirtualTextInfo  ctermfg=4 guifg=#7cafc2
  hi DiagnosticVirtualTextHint  ctermfg=4 guifg=#7cafc2

  augroup diagnostics
    autocmd!
    autocmd DiagnosticChanged * lua vim.diagnostic.setloclist({ open = false })
  augroup end
]])

for _, sign in ipairs(signs) do
  vim.fn.sign_define(
    sign.name,
    {
      texthl = sign.name,
      text = sign.text,
      numhl = ""
    }
  )
end

local config = {
  -- virtual_text = false,
  signs = {
    active = signs,
  },
  -- update_in_insert = true,
  -- underline = true,
  -- severity_sort = true,
  -- float = {
  --   focusable = false,
  --   style = "minimal",
  --   border = "rounded",
  --   source = "always",
  --   header = "",
  --   prefix = "",
  -- },
}

vim.diagnostic.config(config)
