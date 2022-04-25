local u = require("utils")
local M = {}

-- FLoating window
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

u.highlight("NormalFloat", { bg = "#181818" })
u.highlight("FloatBorder", { bg = "#181818", fg = "#383838" })

-- Global LSP mappings
vim.keymap.set("n", "<leader>lh", "<cmd>help lspconfig-server-configurations<cr>")
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
vim.keymap.set("n", "<leader>lp", "<cmd>LspInstallInfo<cr>")

M.on_attach = function(client, bufnr)
  local function buf_nmap(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, { buffer = true })
  end
  local function buf_xmap(lhs, rhs)
    vim.keymap.set("x", lhs, rhs, { buffer = true })
  end

  ---- Commands
  u.command("LspDiagLine", vim.diagnostic.open_float)
  u.command("LspDiagNext", vim.diagnostic.goto_next)
  u.command("LspDiagPrev", vim.diagnostic.goto_prev)
  u.command("LspDiagQuickfix", vim.diagnostic.setqflist)
  u.command("LspFormat", vim.lsp.buf.formatting)
  u.command("LspHover", vim.lsp.buf.hover)
  u.command("LspRangeAction", vim.lsp.buf.range_code_action)
  u.command("LspRename", vim.lsp.buf.rename)
  u.command("LspSignatureHelp", vim.lsp.buf.signature_help)
  u.command("LspTypeDef", vim.lsp.buf.type_definition)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  ---- Bindings
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_nmap("t", vim.lsp.buf.definition)
  buf_nmap("gd", vim.lsp.buf.hover)
  buf_nmap("+t", vim.lsp.buf.signature_help)
  buf_nmap("T", vim.lsp.buf.references)
  buf_nmap("+d", vim.diagnostic.open_float)
  buf_nmap("<leader>la", vim.lsp.buf.code_action)
  buf_nmap("<leader>lr", vim.lsp.buf.rename)
  buf_xmap("<leader>lr", vim.lsp.buf.rename)

  ---- Diagnostics
  buf_nmap("<left>", vim.diagnostic.goto_prev)
  buf_nmap("<right>", vim.diagnostic.goto_next)

  -- show diagnostics of current line
  -- vim.api.nvim_create_autocmd("CursorHold", {
  --   buffer = bufnr,
  --   callback = vim.diagnostic.open_float,
  -- })

  ---- Formatting
  buf_nmap("<leader>b", vim.lsp.buf.formatting_sync)
  buf_xmap("<leader>b", vim.lsp.buf.formatting_sync)

  ---- Document Highlights
  -- if client.resolved_capabilities.document_highlight then
  --   vim.cmd([[
  --     hi! link LspReferenceRead Visual
  --     hi! link LspReferenceText Visual
  --     hi! link LspReferenceWrite Visual
  --   ]])
  --
  --   vim.api.nvim_create_autocmd("CursorHold", {
  --     buffer = bufnr,
  --     callback = vim.lsp.buf.document_highlight,
  --   })
  --
  --   vim.api.nvim_create_autocmd("CursorMoved", {
  --     buffer = bufnr,
  --     callback = vim.lsp.buf.clear_references,
  --   })
  -- end

  ---- Server Options
  if u.has_value(client.name, { "solargraph" }) then
    -- Disable go to definition mappings
    vim.keymap.del("n", "t", { buffer = true })
    vim.keymap.del("n", "T", { buffer = true })

    -- Disable formatting
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  elseif u.has_value(client.name, { "sumneko_lua" }) then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

return M
