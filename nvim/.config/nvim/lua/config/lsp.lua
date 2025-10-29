-- vim.lsp.set_log_level("debug")

vim.keymap.set("n", "<leader>lC", "<cmd>LspActiveClients<cr>")
vim.keymap.set("n", "<leader>lR", ":LspRestart<cr>")
vim.keymap.set("n", "<leader>lh", "<cmd>help lspconfig-all<cr>")
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
vim.keymap.set("n", "<leader>lo", "<cmd>LspLog<cr>")

vim.api.nvim_create_user_command("LspActiveClients", "R=vim.lsp.get_clients()", {})
vim.api.nvim_create_user_command("LspServerCapabilities", "R=vim.lsp.get_clients()[1].server_capabilities", {})
vim.api.nvim_create_user_command("LspServerHandlers", "R=vim.tbl_keys(vim.lsp.handlers)", {})

vim.lsp.enable({
  "bashls",
  "clangd",
  "cssls",
  "emmet_language_server",
  "fish_lsp",
  "gopls",
  -- "herb_ls",
  "html",
  "hyprls",
  "jsonls",
  "just",
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

    vim.keymap.set("n", "t", vim.lsp.buf.definition, { buffer = bufnr, desc = "vim.lsp.buf.definition" })

    if false then
      ---- Signature/Definition
      vim.keymap.set({ "n", "i" }, "<c-s>", vim.lsp.buf.signature_help, {
        buffer = bufnr,
        desc = "vim.lsp.buf.signature_help",
      })

      vim.keymap.set("n", "gd", vim.lsp.buf.hover, { buffer = bufnr, desc = "vim.lsp.buf.hover" })
      vim.keymap.set("i", "<c-h>", vim.lsp.buf.hover, { buffer = bufnr, desc = "vim.lsp.buf.hover" })
      vim.keymap.set("n", "T", vim.lsp.buf.references, { buffer = bufnr, desc = "vim.lsp.buf.references" })
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "vim.lsp.buf.type_definition" })

      ---- Actions
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "vim.lsp.buf.code_action" })
      vim.keymap.set("i", "<m-j>", vim.lsp.buf.code_action, { buffer = bufnr, desc = "vim.lsp.buf.code_action" })
      vim.keymap.set({ "n", "x" }, "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr, desc = "vim.lsp.buf.rename" })

      ---- Symbols
      vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, {
        buffer = bufnr,
        desc = "vim.lsp.buf.document_symbol",
      })

      vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol, {
        buffer = bufnr,
        desc = "vim.lsp.buf.workspace_symbol",
      })

      ---- Diagnostics
      vim.keymap.set("n", "<m-d>", vim.diagnostic.open_float, { buffer = bufnr, desc = "vim.diagnostic.open_float" })

      vim.keymap.set("n", "<left>", function()
        vim.diagnostic.jump({
          count = -1,
          float = true,
        })
      end, { buffer = bufnr, desc = "vim.diagnostic.goto_prev" })

      vim.keymap.set("n", "<right>", function()
        vim.diagnostic.jump({
          count = 1,
          float = true,
        })
      end, { buffer = bufnr, desc = "vim.diagnostic.goto_next" })
    end

    ----Inlay hints
    if client:supports_method("textDocument/inlayHint") then
      local function toggle_inlay_hints()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
        vim.notify("Inlay hints: " .. tostring(vim.lsp.inlay_hint.is_enabled()), vim.log.levels.WARN)
      end

      vim.keymap.set("n", "<leader>lk", toggle_inlay_hints, {
        desc = "vim.lsp.inlay_hint",
        buffer = bufnr,
      })
    end

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

    ----Copilot completions
    if
      vim.lsp.inline_completion
      and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr)
    then
      vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

      vim.keymap.set("i", "<m-cr>", vim.lsp.inline_completion.get, {
        desc = "LSP: accept inline completion",
        buffer = bufnr,
      })

      vim.keymap.set("i", "<m-down>", vim.lsp.inline_completion.select, {
        desc = "LSP: switch inline completion",
        buffer = bufnr,
      })

      local function toggle_inline_completion()
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
          vim.lsp.inline_completion.enable(not vim.lsp.inline_completion.is_enabled())
          vim.notify("Inline completion: " .. tostring(vim.lsp.inline_completion.is_enabled()), vim.log.levels.WARN)
        else
          vim.notify("No inline completion available", vim.log.levels.WARN)
        end
      end

      vim.keymap.set("n", "yoq", toggle_inline_completion, {
        desc = "vim.lsp.inline_completion",
        buffer = bufnr,
      })
    end

    ----Custom server capabilities
    if client.name == "solargraph" then
      client.server_capabilities.documentSymbolProvider = false
    elseif client.name == "eslint" then
      client.server_capabilities.documentFormattingProvider = true
    end
  end,
})
