local M = {}

local u = require("utils")

-- FLoating window
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

u.highlight("NormalFloat", { bg = "#181818" })
u.highlight("FloatBorder", { bg = "#181818", fg = "#383838" })
u.highlight("LspCodeLens", { link = "Comment" })
u.highlight("LspCodeLensSeparator", { link = "Comment" })

-- Global LSP mappings
vim.keymap.set("n", "<leader>lh", "<cmd>help lspconfig-server-configurations<cr>")
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
vim.keymap.set("n", "<leader>lp", "<cmd>Mason<cr>")

M.on_attach = function(client, bufnr)
  local function buf_imap(lhs, rhs, desc)
    vim.keymap.set("i", lhs, rhs, { buffer = true, desc = desc })
  end

  local function buf_nmap(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = true, desc = desc })
  end

  local function buf_xmap(lhs, rhs, desc)
    vim.keymap.set("x", lhs, rhs, { buffer = true, desc = desc })
  end

  ---- Commands
  u.command("LspDiagLine", vim.diagnostic.open_float)
  u.command("LspDiagNext", vim.diagnostic.goto_next)
  u.command("LspDiagPrev", vim.diagnostic.goto_prev)
  u.command("LspDiagQuickfix", vim.diagnostic.setqflist)
  u.command("LspFormat", vim.lsp.buf.format)
  u.command("LspHover", vim.lsp.buf.hover)
  u.command("LspRangeAction", vim.lsp.buf.range_code_action)
  u.command("LspRename", vim.lsp.buf.rename)
  u.command("LspSignatureHelp", vim.lsp.buf.signature_help)
  u.command("LspTypeDef", vim.lsp.buf.type_definition)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  ---- Signature/Definition
  buf_imap("<c-o>", vim.lsp.buf.signature_help, "vim.lsp.buf.signature_help")

  buf_nmap("t", vim.lsp.buf.definition, "vim.lsp.buf.definition")
  buf_nmap("gd", vim.lsp.buf.hover, "vim.lsp.buf.hover")
  buf_nmap("T", vim.lsp.buf.references, "vim.lsp.buf.references")

  ---- Actions
  buf_nmap("<leader>la", vim.lsp.buf.code_action, "vim.lsp.buf.code_action")
  buf_nmap("<leader>lr", vim.lsp.buf.rename, "vim.lsp.buf.rename")
  buf_xmap("<leader>lr", vim.lsp.buf.rename, "vim.lsp.buf.rename")

  ---- Symbols
  buf_nmap("<leader>r", vim.lsp.buf.document_symbol, "vim.lsp.buf.document_symbol")
  buf_nmap("<leader>R", vim.lsp.buf.workspace_symbol, "vim.lsp.buf.workspace_symbol")

  ---- Diagnostics
  buf_nmap("<m-d>", vim.diagnostic.open_float, "vim.diagnostic.open_float")
  buf_nmap("∂", vim.diagnostic.open_float, "vim.diagnostic.open_float") -- alt+d
  buf_nmap("<left>", vim.diagnostic.goto_prev, "vim.diagnostic.goto_prev")
  buf_nmap("<right>", vim.diagnostic.goto_next, "vim.diagnostic.goto_next")

  -- -- show diagnostics of current line
  -- vim.api.nvim_create_autocmd("CursorHold", {
  --   buffer = bufnr,
  --   callback = vim.diagnostic.open_float,
  -- })

  ---- Formatting
  buf_nmap("<leader>b", function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end, "vim.lsp.buf.format")

  buf_xmap("<leader>b", function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end, "vim.lsp.buf.format")

  ---- fzf-lua
  local ok_fzf, fzf_lua = pcall(require, "fzf-lua")
  if ok_fzf then
    buf_nmap("<leader>r", fzf_lua.lsp_document_symbols, "fzf_lua.lsp_document_symbols")
    buf_nmap("<leader>R", fzf_lua.lsp_workspace_symbols, "fzf_lua.lsp_workspace_symbols")

    buf_nmap("<leader>ld", fzf_lua.lsp_workspace_diagnostics, "fzf_lua.lsp_workspace_diagnostics")
  end

  ---- lspsaga
  local ok_lspsaga, _ = pcall(require, "lspsaga")
  if ok_lspsaga then
    ---- definition
    buf_nmap("gd", "<cmd>Lspsaga hover_doc<cr>")
    buf_nmap("T", "<cmd>Lspsaga lsp_finder<cr>")
    buf_nmap("<leader>lf", "<cmd>Lspsaga peek_definition<cr>")

    ---- actions
    buf_nmap("<leader>la", "<cmd>Lspsaga code_action<cr>")
    buf_xmap("<leader>la", "<cmd>Lspsaga code_action<cr>")
    buf_nmap("<leader>lr", "<cmd>Lspsaga rename<cr>")
    buf_xmap("<leader>lr", "<cmd>Lspsaga rename<cr>")

    ---- diagnostics
    buf_nmap("∂", "<cmd>Lspsaga show_line_diagnostics<cr>") -- alt+d
    buf_nmap("<m-d>", "<cmd>Lspsaga show_line_diagnostics<cr>")
    buf_nmap("<left>", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
    buf_nmap("<right>", "<cmd>Lspsaga diagnostic_jump_next<cr>")

    ---- outline
    buf_nmap("<leader>lo", "<cmd>LSoutlineToggle<cr>")
  end

  ---- Codelens
  -- local status_ok, codelens_supported = pcall(function()
  --   return client.supports_method("textDocument/codeLens")
  -- end)
  --
  -- if status_ok and codelens_supported then
  --   local augroup_exist, _ = pcall(vim.api.nvim_get_autocmds, {
  --     group = "lsp_codelens_refresh",
  --   })
  --
  --   if not augroup_exist then
  --     vim.api.nvim_create_augroup("lsp_codelens_refresh", {})
  --   end
  --
  --   vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
  --     group = "lsp_codelens_refresh",
  --     buffer = bufnr,
  --     callback = vim.lsp.codelens.refresh,
  --   })
  --
  --   buf_nmap("<leader>lR", vim.lsp.codelens.run, "vim.lsp.codelens.run")
  -- end

  ---- Document Highlights
  -- if client.server_capabilities.document_highlight then
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
  if vim.tbl_contains({ "sqls", "sumneko_lua" }, client.name) then
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end
end

---- Additional capabilities
-- nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- nvim-ufo
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }

M.capabilities = capabilities

return M