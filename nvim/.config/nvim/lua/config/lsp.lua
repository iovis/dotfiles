---- Floating window
require("lspconfig.ui.windows").default_options.border = "rounded"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

---- LSP Format
local autoformat_augroup = vim.api.nvim_create_augroup("lsp_document_format", { clear = false })

---- On LSP attached buffers
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  local function buf_imap(lhs, rhs, desc)
    vim.keymap.set("i", lhs, rhs, { buffer = true, desc = desc })
  end

  local function buf_nmap(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = true, desc = desc })
  end

  local function buf_xmap(lhs, rhs, desc)
    vim.keymap.set("x", lhs, rhs, { buffer = true, desc = desc })
  end

  ---- Signature/Definition
  buf_imap("<m-d>", vim.lsp.buf.hover, "vim.lsp.buf.hover")
  buf_imap("<c-h>", vim.lsp.buf.signature_help, "vim.lsp.buf.signature_help")

  buf_nmap("T", vim.lsp.buf.references, "vim.lsp.buf.references")
  buf_nmap("gd", vim.lsp.buf.hover, "vim.lsp.buf.hover")
  buf_nmap("gt", vim.lsp.buf.type_definition, "vim.lsp.buf.type_definition")
  buf_nmap("t", vim.lsp.buf.definition, "vim.lsp.buf.definition")

  ---- Actions
  buf_imap("<m-j>", vim.lsp.buf.code_action, "vim.lsp.buf.code_action")
  buf_nmap("<leader>la", vim.lsp.buf.code_action, "vim.lsp.buf.code_action")

  buf_nmap("<leader>lr", vim.lsp.buf.rename, "vim.lsp.buf.rename")
  buf_xmap("<leader>lr", vim.lsp.buf.rename, "vim.lsp.buf.rename")

  ---- Symbols
  buf_nmap("<leader>ls", vim.lsp.buf.document_symbol, "vim.lsp.buf.document_symbol")
  buf_nmap("<leader>lw", vim.lsp.buf.workspace_symbol, "vim.lsp.buf.workspace_symbol")

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
  buf_nmap("<leader>b", vim.lsp.buf.format, "vim.lsp.buf.format")
  buf_xmap("<leader>b", vim.lsp.buf.format, "vim.lsp.buf.format")

  -- Autoformat on save
  local no_autoformat_filetypes = {}

  if
    client.supports_method("textDocument/formatting")
    and not vim.tbl_contains(no_autoformat_filetypes, vim.bo.filetype)
  then
    vim.api.nvim_clear_autocmds({ group = autoformat_augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "Autoformat with LSP on save",
      group = autoformat_augroup,
      buffer = bufnr,
      callback = function()
        if vim.g.autoformat then
          vim.lsp.buf.format({
            filter = function(server)
              local dont_format_with = {
                "fuzzy_ls",
                "html",
                "ruby_ls",
                "solargraph",
              }

              return not vim.tbl_contains(dont_format_with, server.name)
            end,
          })
        end
      end,
    })
  end

  ---- fzf-lua
  local ok_fzf, fzf_lua = pcall(require, "fzf-lua")
  if ok_fzf then
    buf_nmap("<leader>ls", fzf_lua.lsp_document_symbols, "fzf_lua.lsp_document_symbols")
    buf_nmap("<leader>lw", fzf_lua.lsp_workspace_symbols, "fzf_lua.lsp_workspace_symbols")

    buf_nmap("<leader>ld", fzf_lua.lsp_workspace_diagnostics, "fzf_lua.lsp_workspace_diagnostics")
  end

  ---- telescope
  local ok_telescope, telescope = pcall(require, "telescope.builtin")
  if ok_telescope then
    buf_nmap("<leader>ls", telescope.lsp_document_symbols, "telescope.lsp_document_symbols")
    buf_nmap("<leader>lw", telescope.lsp_workspace_symbols, "telescope.lsp_workspace_symbols")

    buf_nmap("<leader>ld", telescope.diagnostics, "telescope.lsp_workspace_diagnostics")
  end

  ---- lspsaga
  local ok_lspsaga, _ = pcall(require, "lspsaga")
  if ok_lspsaga then
    ---- definition
    buf_imap("<m-d>", "<cmd>Lspsaga hover_doc<cr>")
    buf_nmap("gd", "<cmd>Lspsaga hover_doc<cr>")
    buf_nmap("gt", "<cmd>Lspsaga goto_type_definition<cr>")

    buf_nmap("T", "<cmd>Lspsaga finder<cr>")
    buf_nmap("<leader>lf", "<cmd>Lspsaga peek_definition<cr>")
    buf_nmap("<leader>lt", "<cmd>Lspsaga peek_type_definition<cr>")

    ---- actions
    buf_imap("<m-j>", "<cmd>Lspsaga code_action<cr>")
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
    buf_nmap("<leader>lo", "<cmd>Lspsaga outline<cr>")
  end

  ----Inlay hints
  if vim.fn.has("nvim-0.10") == 1 then
    vim.g.inlay_hints_visible = false

    local function toggle_inlay_hints()
      if vim.g.inlay_hints_visible then
        vim.g.inlay_hints_visible = false
        vim.lsp.inlay_hint.enable(bufnr, false)
      else
        if client.server_capabilities.inlayHintProvider then
          vim.g.inlay_hints_visible = true
          vim.lsp.inlay_hint.enable(bufnr, true)
        else
          print("no inlay hints available")
        end
      end
    end

    buf_nmap("<leader>lk", toggle_inlay_hints, "vim.lsp.inlay_hint")
  end

  if client.name == "solargraph" then
    client.server_capabilities.documentSymbolProvider = false
  end

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
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
  -- if client.server_capabilities.documentHighlightProvider then
  --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  --     buffer = bufnr,
  --     callback = vim.lsp.buf.document_highlight,
  --   })
  --
  --   vim.api.nvim_create_autocmd("CursorMoved", {
  --     buffer = bufnr,
  --     callback = vim.lsp.buf.clear_references,
  --   })
  -- end
end

---- Additional capabilities
-- nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

return {
  capabilities = capabilities,
  on_attach = on_attach,
}
