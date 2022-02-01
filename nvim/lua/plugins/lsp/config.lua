local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local u = require("utils")
local M = {}

-- Bring up docs for server configurations
u.nmap("<leader>lh", ":help lspconfig-server-configurations<cr>")

-- Highlights for vim.lsp.buf.document_highlight
vim.cmd([[
  hi LspReferenceText  ctermbg=19 guibg=#383838
  hi LspReferenceRead  ctermbg=19 guibg=#383838
  hi LspReferenceWrite ctermbg=19 guibg=#383838
]])

local lsp_commands = function()
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
end

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
  buf_nmap("+t", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  buf_nmap("<space>lp", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  buf_nmap("T", "<cmd>lua vim.lsp.buf.references()<CR>")
  buf_nmap("<left>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  buf_nmap("<right>", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  buf_nmap("<space>b", ":LspFormat<cr>")
end

local function lsp_document_highlights(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorHold,CursorHoldI <buffer> lua vim.diagnostic.open_float(nil, {focus=false})
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

M.on_attach = function(client, bufnr)
  lsp_commands()
  lsp_keymaps(bufnr)
  lsp_document_highlights(client)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

return M
