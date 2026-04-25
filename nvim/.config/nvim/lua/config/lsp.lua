-- vim.lsp.set_log_level("debug")

vim.keymap.set("n", "<leader>lR", ":lsp restart<cr>")
vim.keymap.set("n", "<leader>lh", "<cmd>help lspconfig-all<cr>")
vim.keymap.set("n", "<leader>lo", "<cmd>LspLog<cr>")

vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", {})
vim.api.nvim_create_user_command("LspActiveClients", "R=vim.lsp.get_clients({ bufnr = 0 })", {})
vim.api.nvim_create_user_command(
  "LspServerCapabilities",
  "R=vim.lsp.get_clients({ bufnr = 0 })[1].server_capabilities",
  {}
)

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd("tabnew " .. vim.lsp.log.get_filename())
  vim.keymap.set("n", "q", "<cmd>close<cr>", {
    buf = 0,
    nowait = true,
  })
end, {})

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
  "zls",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    if not client then
      return
    end

    vim.keymap.set("n", "t", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition", buf = bufnr })
    vim.keymap.set("n", "<leader>lx", vim.lsp.codelens.run, { desc = "vim.lsp.codelens.run", buf = bufnr })

    ---- Signature/Definition
    vim.keymap.set({ "n", "i" }, "<c-s>", vim.lsp.buf.signature_help, {
      desc = "vim.lsp.buf.signature_help",
      buf = bufnr,
    })

    vim.keymap.set("n", "gd", vim.lsp.buf.hover, { desc = "vim.lsp.buf.hover", buf = bufnr })
    vim.keymap.set("i", "<c-h>", vim.lsp.buf.hover, { desc = "vim.lsp.buf.hover", buf = bufnr })
    vim.keymap.set("n", "T", vim.lsp.buf.references, { desc = "vim.lsp.buf.references", buf = bufnr })
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "vim.lsp.buf.type_definition", buf = bufnr })

    ---- Actions
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "vim.lsp.buf.code_action", buf = bufnr })
    vim.keymap.set("i", "<m-j>", vim.lsp.buf.code_action, { desc = "vim.lsp.buf.code_action", buf = bufnr })
    vim.keymap.set({ "n", "x" }, "<leader>lr", vim.lsp.buf.rename, { desc = "vim.lsp.buf.rename", buf = bufnr })
    vim.keymap.set("n", "<leader>lx", vim.lsp.codelens.run, { desc = "vim.lsp.codelens.run", buf = bufnr })

    ---- Symbols
    vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, {
      desc = "vim.lsp.buf.document_symbol",
      buf = bufnr,
    })

    vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol, {
      desc = "vim.lsp.buf.workspace_symbol",
      buf = bufnr,
    })

    ---- Diagnostics
    vim.keymap.set("n", "<m-d>", vim.diagnostic.open_float, { desc = "vim.diagnostic.open_float", buf = bufnr })

    vim.keymap.set("n", "<left>", function()
      vim.diagnostic.jump({
        count = -1,
        float = true,
      })
    end, { desc = "vim.diagnostic.jump prev", buf = bufnr })

    vim.keymap.set("n", "<right>", function()
      vim.diagnostic.jump({
        count = 1,
        float = true,
      })
    end, { desc = "vim.diagnostic.jump next", buf = bufnr })

    ---- Lspsaga
    -- peek
    vim.keymap.set("i", "<c-h>", "<cmd>Lspsaga hover_doc<cr>", { buf = bufnr })
    vim.keymap.set("n", "gd", "<cmd>Lspsaga hover_doc<cr>", { buf = bufnr })
    vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<cr>", { buf = bufnr })
    vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga peek_definition<cr>", { buf = bufnr })
    vim.keymap.set("n", "<leader>lt", "<cmd>Lspsaga peek_type_definition<cr>", { buf = bufnr })

    -- actions
    vim.keymap.set("i", "<m-j>", "<cmd>Lspsaga code_action<cr>", { buf = bufnr })
    vim.keymap.set({ "n", "x" }, "<leader>la", "<cmd>Lspsaga code_action<cr>", { buf = bufnr })
    vim.keymap.set({ "n", "x" }, "<leader>lr", "<cmd>Lspsaga rename<cr>", { buf = bufnr })

    -- diagnostics
    vim.keymap.set("n", "<m-d>", "<cmd>Lspsaga show_line_diagnostics<cr>", { buf = bufnr })
    vim.keymap.set("n", "<left>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { buf = bufnr })
    vim.keymap.set("n", "<right>", "<cmd>Lspsaga diagnostic_jump_next<cr>", { buf = bufnr })

    ---- Snacks
    vim.keymap.set("n", "<leader>ls", Snacks.picker.lsp_symbols, {
      desc = "Snacks.picker.lsp_symbols",
      buf = bufnr,
    })

    vim.keymap.set("n", "<leader>lw", Snacks.picker.lsp_workspace_symbols, {
      desc = "Snacks.picker.lsp_workspace_symbols",
      buf = bufnr,
    })

    vim.keymap.set("n", "<leader>ld", function()
      Snacks.picker.diagnostics({ focus = "list" })
    end, {
      desc = "Snacks.picker.diagnostics",
      buf = bufnr,
    })

    vim.keymap.set("n", "T", function()
      Snacks.picker.lsp_references({ focus = "list" })
    end, {
      desc = "Snacks.picker.lsp_references",
      buf = bufnr,
    })

    ---- Inlay hints
    if client:supports_method("textDocument/inlayHint") then
      local function toggle_inlay_hints()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
        vim.notify("Inlay hints: " .. tostring(vim.lsp.inlay_hint.is_enabled()), vim.log.levels.WARN)
      end

      vim.keymap.set("n", "<leader>lk", toggle_inlay_hints, {
        desc = "toggle vim.lsp.inlay_hint",
        buf = bufnr,
      })
    end

    ---- Codelens
    local function toggle_codelens()
      vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
      vim.notify("LSP Codelens: " .. tostring(vim.lsp.codelens.is_enabled()), vim.log.levels.WARN)
    end

    vim.keymap.set("n", "yoc", toggle_codelens, {
      desc = "toggle vim.lsp.codelens",
      buf = bufnr,
    })

    ---- Commands
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
  end,
})
