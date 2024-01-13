---- UI
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, {
    texthl = sign.name,
    text = sign.text,
    numhl = "",
  })
end

---- Configuration
local config = {
  float = {
    focusable = true,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = "rounded",
    source = "always", -- show source in diagnostic popup window
    prefix = " ",
  },
  severity_sort = true,
  signs = {
    active = signs,
  },
  underline = {
    severity = {
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.ERROR,
    },
  },
  virtual_text = true,
}

vim.diagnostic.config(config)

---- Set Diagnostics on location list
vim.keymap.set("n", "Ç", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

---- Toggle diagnostics
vim.g.diagnostics_visible = true

local toggle_diagnostics = function()
  if vim.g.diagnostics_visible then
    vim.g.diagnostics_visible = false
    vim.diagnostic.disable()
    vim.notify("Diagnostics disabled")
  else
    vim.g.diagnostics_visible = true
    vim.diagnostic.enable()
    vim.notify("Diagnostics enabled")
  end
end

vim.g.diagnostics_virtual = true
local toggle_diagnostics_virtual = function()
  vim.g.diagnostics_virtual = not vim.g.diagnostics_virtual
  vim.diagnostic.config({ virtual_text = vim.g.diagnostics_virtual })

  if vim.g.diagnostics_virtual then
    vim.notify("Hide diagnostics virtual text")
  else
    vim.notify("Show diagnostics virtual text")
  end
end

vim.keymap.set("n", "yoz", toggle_diagnostics, { desc = "toggle diagnostics" })
vim.keymap.set("n", "yov", toggle_diagnostics_virtual, { desc = "toggle virtual text diagnostics" })
