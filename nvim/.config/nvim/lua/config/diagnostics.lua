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
local augroup = vim.api.nvim_create_augroup("diagnostics", { clear = true })
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  pattern = "*",
  callback = function()
    vim.diagnostic.setloclist({ open = false })
  end,
  group = augroup,
  desc = "Set diagnostics on location list",
})

vim.keymap.set("n", "|", vim.diagnostic.setloclist, {
  desc = "Open diagnostics list",
})

---- Toggle diagnostics
vim.keymap.set("n", "yoD", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "toggle diagnostics" })
