local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local u = require("utils")
local M = {}

u.lua_command("LspFormat", "vim.lsp.buf.formatting()")
u.lua_command("LspRename", "vim.lsp.buf.rename()")

u.nmap("<leader>lh", ":help lspconfig-server-configurations<cr>")
u.nmap("<space>b", ":LspFormat<cr>")

local lsp_keymaps = function(bufnr)
  local function buf_nmap(...)
    u.buf_map(bufnr, "n", ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_nmap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  buf_nmap("t", "<cmd>lua vim.lsp.buf.definition()<CR>")
  buf_nmap("gd", "<cmd>lua vim.lsp.buf.hover()<CR>")
  buf_nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  buf_nmap("+d", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded' })<CR>")
  buf_nmap("+t", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  buf_nmap("<space>lp", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  buf_nmap("T", "<cmd>lua vim.lsp.buf.references()<CR>")
  buf_nmap("<left>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  buf_nmap("<right>", "<cmd>lua vim.diagnostic.goto_next()<CR>")

  -- buf_nmap('<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  -- buf_nmap('<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  -- buf_nmap('<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  -- buf_nmap('<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  -- buf_nmap('<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  -- buf_nmap('<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
  -- buf_nmap('<space>ç', '<cmd>lua vim.diagnostic.setloclist()<CR>')
  -- buf_nmap('<space>b', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  -- lsp_highlight_document(client)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

return M
