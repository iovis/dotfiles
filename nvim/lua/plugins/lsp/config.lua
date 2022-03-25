local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local u = require("utils")
local M = {}

-- Rounded borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.cmd([[
  hi NormalFloat ctermbg=0 guibg=#181818
  hi FloatBorder ctermfg=19 ctermbg=0 guifg=#383838 guibg=#181818
]])

-- Bring up docs for server configurations
u.nmap("<leader>lh", ":help lspconfig-server-configurations<cr>")

M.on_attach = function(client, bufnr)
  local function buf_nmap(...)
    u.buf_map(bufnr, "n", ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  ---- Commands
  u.lua_command("LspDiagLine", "vim.diagnostic.open_float()")
  u.lua_command("LspDiagNext", "vim.diagnostic.goto_next()")
  u.lua_command("LspDiagPrev", "vim.diagnostic.goto_prev()")
  u.lua_command("LspDiagQuickfix", "vim.diagnostic.setqflist()")
  u.lua_command("LspFormat", "vim.lsp.buf.formatting()")
  u.lua_command("LspHover", "vim.lsp.buf.hover()")
  u.lua_command("LspRangeAct", "vim.lsp.buf.range_code_action()")
  u.lua_command("LspRename", "vim.lsp.buf.rename()")
  u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")
  u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  ---- Bindings
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_nmap("t", "<cmd>lua vim.lsp.buf.definition()<CR>")
  buf_nmap("gd", "<cmd>lua vim.lsp.buf.hover()<CR>")
  buf_nmap("+t", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  buf_nmap("T", "<cmd>lua vim.lsp.buf.references()<CR>")

  -- List code actions
  buf_nmap(
    "<space>la",
    "<cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()[1].resolved_capabilities.code_action))<CR>"
  )
  buf_nmap("<space>lp", "<cmd>lua vim.lsp.buf.code_action()<CR>")

  ---- Diagnostics
  buf_nmap("<left>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  buf_nmap("<right>", "<cmd>lua vim.diagnostic.goto_next()<CR>")

  vim.cmd([[
    autocmd CursorHold <buffer> lua vim.diagnostic.open_float()
  ]])

  ---- Formatting
  buf_nmap("<space>b", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>")
  u.buf_map(bufnr, "x", "<space>b", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>")

  -- NOTE: Formatting conflicts
  -----------------------------
  -- If when formatting there are multiple possible candidates for
  -- formatting, Neovim will ask you which one to use. If you want to use
  -- null-ls formatting you can disable the conflicting language's
  -- formatting capabilities.
  -- See: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
  if u.has_value(client.name, { "solargraph" }) then
    -- Disable go to definition mappings
    vim.api.nvim_buf_del_keymap(0, 'n', 't')
    vim.api.nvim_buf_del_keymap(0, 'n', 'T')

    -- Disable formatting
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  ---- Document Highlights
  -- if client.resolved_capabilities.document_highlight then
  --   vim.cmd([[
  --     hi! link LspReferenceRead Visual
  --     hi! link LspReferenceText Visual
  --     hi! link LspReferenceWrite Visual
  --
  --     augroup lsp_document_highlight
  --       autocmd! * <buffer>
  --       autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
  --       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --   ]])
  -- end
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

return M
