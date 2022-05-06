local u = require("utils")

local augroup = vim.api.nvim_create_augroup("diagnostics", { clear = true })
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  pattern = "*",
  callback = function()
    vim.diagnostic.setloclist({ open = false })
  end,
  group = augroup,
  desc = "Set diagnostics on location list",
})

u.highlight("DiagnosticSignError", { fg = "#ab4642" })
u.highlight("DiagnosticSignWarn",  { fg = "#f7ca88" })
u.highlight("DiagnosticSignInfo",  { fg = "#7cafc2" })
u.highlight("DiagnosticSignHint",  { fg = "#7cafc2" })

u.highlight("DiagnosticVirtualTextError", { fg = "#ab4642" })
u.highlight("DiagnosticVirtualTextWarn",  { fg = "#f7ca88" })
u.highlight("DiagnosticVirtualTextInfo",  { fg = "#7cafc2" })
u.highlight("DiagnosticVirtualTextHint",  { fg = "#7cafc2" })

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, {
    texthl = sign.name,
    text = sign.text,
    numhl = "",
  })
end

local config = {
  float = {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = "rounded",
    source = "always", -- show source in diagnostic popup window
    prefix = " ",
  },
  signs = {
    active = signs,
  },
  underline = {
    severity = vim.diagnostic.severity.ERROR,
  },
  virtual_text = true,
}

vim.diagnostic.config(config)
