---- Floating window
require("lspconfig.ui.windows").default_options.border = "rounded"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

---- On LSP attached buffers
local on_attach = function(client, bufnr)
  local imap = function(lhs, rhs, desc)
    vim.keymap.set("i", lhs, rhs, { buffer = bufnr, desc = desc })
  end

  local nmap = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
  end

  local xmap = function(lhs, rhs, desc)
    vim.keymap.set("x", lhs, rhs, { buffer = bufnr, desc = desc })
  end

  ---- Signature/Definition
  nmap("<c-s>", vim.lsp.buf.signature_help, "vim.lsp.buf.signature_help")
  imap("<c-s>", vim.lsp.buf.signature_help, "vim.lsp.buf.signature_help")
  imap("<c-h>", vim.lsp.buf.hover, "vim.lsp.buf.hover")

  nmap("T", vim.lsp.buf.references, "vim.lsp.buf.references")
  nmap("gd", vim.lsp.buf.hover, "vim.lsp.buf.hover")
  nmap("gt", vim.lsp.buf.type_definition, "vim.lsp.buf.type_definition")
  nmap("t", vim.lsp.buf.definition, "vim.lsp.buf.definition")

  ---- Actions
  imap("<m-j>", vim.lsp.buf.code_action, "vim.lsp.buf.code_action")
  nmap("<leader>la", vim.lsp.buf.code_action, "vim.lsp.buf.code_action")

  nmap("<leader>lr", vim.lsp.buf.rename, "vim.lsp.buf.rename")
  xmap("<leader>lr", vim.lsp.buf.rename, "vim.lsp.buf.rename")

  ---- Symbols
  nmap("<leader>ls", vim.lsp.buf.document_symbol, "vim.lsp.buf.document_symbol")
  nmap("<leader>lw", vim.lsp.buf.workspace_symbol, "vim.lsp.buf.workspace_symbol")

  ---- Diagnostics
  nmap("<m-d>", vim.diagnostic.open_float, "vim.diagnostic.open_float")
  nmap("∂", vim.diagnostic.open_float, "vim.diagnostic.open_float") -- alt+d
  nmap("<left>", vim.diagnostic.goto_prev, "vim.diagnostic.goto_prev")
  nmap("<right>", vim.diagnostic.goto_next, "vim.diagnostic.goto_next")

  ---- fzf-lua
  local ok_fzf, fzf_lua = pcall(require, "fzf-lua")
  if ok_fzf then
    nmap("<leader>ls", fzf_lua.lsp_document_symbols, "fzf_lua.lsp_document_symbols")
    nmap("<leader>lw", fzf_lua.lsp_workspace_symbols, "fzf_lua.lsp_workspace_symbols")

    nmap("<leader>ld", fzf_lua.lsp_workspace_diagnostics, "fzf_lua.lsp_workspace_diagnostics")
  end

  ---- lspsaga
  local ok_lspsaga, _ = pcall(require, "lspsaga")
  if ok_lspsaga then
    ---- definition
    imap("<c-h>", "<cmd>Lspsaga hover_doc<cr>")
    nmap("gd", "<cmd>Lspsaga hover_doc<cr>")
    nmap("gt", "<cmd>Lspsaga goto_type_definition<cr>")

    nmap("T", "<cmd>Lspsaga finder<cr>")
    nmap("<leader>lf", "<cmd>Lspsaga peek_definition<cr>")
    nmap("<leader>lt", "<cmd>Lspsaga peek_type_definition<cr>")

    ---- actions
    imap("<m-j>", "<cmd>Lspsaga code_action<cr>")
    nmap("<leader>la", "<cmd>Lspsaga code_action<cr>")
    xmap("<leader>la", "<cmd>Lspsaga code_action<cr>")

    nmap("<leader>lr", "<cmd>Lspsaga rename<cr>")
    xmap("<leader>lr", "<cmd>Lspsaga rename<cr>")

    ---- diagnostics
    nmap("∂", "<cmd>Lspsaga show_line_diagnostics<cr>") -- alt+d
    nmap("<m-d>", "<cmd>Lspsaga show_line_diagnostics<cr>")
    nmap("<left>", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
    nmap("<right>", "<cmd>Lspsaga diagnostic_jump_next<cr>")

    ---- outline
    nmap("<leader>lo", "<cmd>Lspsaga outline<cr>")
  end

  ----Inlay hints
  if vim.fn.has("nvim-0.10") == 1 then
    local function toggle_inlay_hints()
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      else
        vim.notify("No inlay hints available", vim.log.levels.WARN)
      end
    end

    nmap("<leader>lk", toggle_inlay_hints, "vim.lsp.inlay_hint")
  end

  ----Custom server capabilities
  if client.name == "solargraph" then
    client.server_capabilities.documentSymbolProvider = false
  elseif client.name == "eslint" then
    client.server_capabilities.documentFormattingProvider = true
  end

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
end

---- Additional capabilities
-- nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

return {
  capabilities = capabilities,
  on_attach = on_attach,
}
