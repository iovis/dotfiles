-- vim.lsp.set_log_level("debug")

vim.keymap.set("n", "<leader>lR", ":LspRestart<cr>")
vim.keymap.set("n", "<leader>lh", "<cmd>help lspconfig-all<cr>")
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
vim.keymap.set("n", "<leader>ll", "<cmd>LspLog<cr>")

vim.api.nvim_create_user_command("LspActiveClients", "R=vim.lsp.get_clients()", {})

vim.lsp.enable({
  "bashls",
  "clangd",
  "cmake",
  "cssls",
  "dockerls",
  "emmet_language_server",
  "fish_lsp",
  "gopls",
  "html",
  "jsonls",
  "just",
  "lua_ls",
  -- "marksman",
  "ruby_lsp",
  "rust_analyzer",
  "solargraph",
  "sourcekit",
  "svelte",
  "taplo",
  "ts_ls",
  "yamlls",
  "zls",
})

vim.lsp.config("html", {
  settings = {
    html = {
      format = {
        extraLiners = "",
        templating = true,
      },
    },
  },
  filetypes = {
    "eruby",
    "html",
  },
})

vim.lsp.config("jsonls", {
  settings = {
    json = {
      -- https://www.schemastore.org/json/
      -- https://github.com/b0o/schemastore.nvim
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostics = {
        disable = { "missing-fields" },
        unusedLocalExclude = { "_*" }, -- Don't warn about variables that start with underscore
      },
      format = { enable = false },
      hint = { enable = true },
      -- workspace = { checkThirdParty = false },
    },
  },
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      checkOnSave = {
        command = "clippy",
        extraArgs = {
          "--",
          "-Wclippy::pedantic",
          "-Aclippy::missing-errors-doc",
          "-Aclippy::missing-panics-doc",
          "-Aclippy::must-use-candidate",
          "-Aclippy::needless_range_loop",
        },
      },
    },
  },
})

vim.lsp.config("solargraph", {
  settings = {
    solargraph = {
      diagnostics = false,
      autoformat = false,
      formatting = false,
      -- useBundler = true,
    },
  },
})

vim.lsp.config("sourcekit", { filetypes = { "swift" } })

vim.lsp.config("ts_ls", {
  commands = {
    LspRemoveUnused = {
      function()
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            ---@diagnostic disable-next-line: assign-type-mismatch
            only = { "source.removeUnused.ts" },
            diagnostics = {},
          },
        })
      end,
      description = "Remove unused",
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      },
    },
  },
})

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = require("schemastore").yaml.schemas(),
      schemaStore = {
        enable = false,
        url = "",
      },
    },
  },
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
    nmap("<leader>ls", vim.lsp.buf.document_symbol, "vim.lsp.buf.document_symbol")
    nmap("<leader>lw", vim.lsp.buf.workspace_symbol, "vim.lsp.buf.workspace_symbol")

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
    local function toggle_inlay_hints()
      if client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
      else
        vim.notify("No inlay hints available", vim.log.levels.WARN)
      end
    end

    nmap("<leader>lk", toggle_inlay_hints, "vim.lsp.inlay_hint")

    ----Code Actions
    nmap("<leader>lI", ":LspOrganizeImports<cr>")
    vim.api.nvim_buf_create_user_command(0, "LspOrganizeImports", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.organizeImports" },
          diagnostics = {},
        },
      })
    end, {})

    ----Custom server capabilities
    if client.name == "solargraph" then
      client.server_capabilities.documentSymbolProvider = false
    elseif client.name == "eslint" then
      client.server_capabilities.documentFormattingProvider = true
    end
  end,
})
