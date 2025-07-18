-- vim.lsp.set_log_level("debug")

vim.keymap.set("n", "<leader>lC", "<cmd>LspActiveClients<cr>")
vim.keymap.set("n", "<leader>lR", ":LspRestart<cr>")
vim.keymap.set("n", "<leader>lh", "<cmd>help lspconfig-all<cr>")
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
vim.keymap.set("n", "<leader>lo", "<cmd>LspLog<cr>")

vim.api.nvim_create_user_command("LspActiveClients", "R=vim.lsp.get_clients()", {})

vim.lsp.enable({
  "bashls",
  "clangd",
  "cssls",
  "emmet_language_server",
  "fish_lsp",
  "gopls",
  "html",
  "hyprls",
  "jsonls",
  "just",
  -- "kulala_ls",
  "lua_ls",
  "ruby_lsp",
  "rust_analyzer",
  "tombi",
  "ts_ls",
  "yamlls",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    if not client then
      return
    end

    local function imap(lhs, rhs, desc)
      vim.keymap.set("i", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    local function nmap(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    local function xmap(lhs, rhs, desc)
      vim.keymap.set("x", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    ---- Signature/Definition
    nmap("<c-s>", vim.lsp.buf.signature_help, "vim.lsp.buf.signature_help")
    -- imap("<c-s>", vim.lsp.buf.signature_help, "vim.lsp.buf.signature_help")
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
    -- nmap("<leader>ls", vim.lsp.buf.document_symbol, "vim.lsp.buf.document_symbol")
    -- nmap("<leader>lw", vim.lsp.buf.workspace_symbol, "vim.lsp.buf.workspace_symbol")

    ---- Diagnostics
    nmap("<m-d>", vim.diagnostic.open_float, "vim.diagnostic.open_float")
    nmap("∂", vim.diagnostic.open_float, "vim.diagnostic.open_float") -- alt+d

    nmap("<left>", function()
      vim.diagnostic.jump({
        count = -1,
        float = true,
      })
    end, "vim.diagnostic.goto_prev")

    nmap("<right>", function()
      vim.diagnostic.jump({
        count = 1,
        float = true,
      })
    end, "vim.diagnostic.goto_next")

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
      nmap("<leader>lm", "<cmd>Lspsaga outline<cr>")
    end

    ----Inlay hints
    local function toggle_inlay_hints()
      if client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
      else
        vim.notify("No inlay hints available", vim.log.levels.WARN)
      end
    end

    nmap("<leader>lk", toggle_inlay_hints, "vim.lsp.inlay_hint")

    ----Code Actions
    -- nmap("<leader>lI", ":LspOrganizeImports<cr>")
    -- vim.api.nvim_buf_create_user_command(0, "LspOrganizeImports", function()
    --   vim.lsp.buf.code_action({
    --     apply = true,
    --     context = {
    --       only = { "source.organizeImports" },
    --       diagnostics = {},
    --     },
    --   })
    -- end, {})

    ----Custom server capabilities
    if client.name == "solargraph" then
      client.server_capabilities.documentSymbolProvider = false
    elseif client.name == "eslint" then
      client.server_capabilities.documentFormattingProvider = true
    end
  end,
})
