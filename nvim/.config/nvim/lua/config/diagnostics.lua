local multiline_diagnostics = false
local virtual_text = true

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
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.WARN] = "",
    },
  },
  underline = {
    severity = {
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.ERROR,
    },
  },
  virtual_lines = multiline_diagnostics,
  virtual_text = virtual_text, -- { current_line = true },
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
end, { desc = "Toggle diagnostics" })

---- Toggle multiline diagnostics
vim.keymap.set("n", "yoe", function()
  multiline_diagnostics = not multiline_diagnostics

  vim.diagnostic.config({
    virtual_lines = multiline_diagnostics,
    virtual_text = not multiline_diagnostics,
  })
end, { desc = "Toggle multiline diagnostics" })

---- Toggle virtual text diagnostics
vim.keymap.set("n", "yov", function()
  virtual_text = not virtual_text

  vim.diagnostic.config({ virtual_text = virtual_text })
end, { desc = "Toggle diagnostics on current line" })
