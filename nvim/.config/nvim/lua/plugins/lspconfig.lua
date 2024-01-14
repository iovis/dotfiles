return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "b0o/schemastore.nvim",
    "folke/neodev.nvim",
    -- "lvimuser/lsp-inlayhints.nvim",
    "simrat39/rust-tools.nvim",
    {
      "williamboman/mason.nvim",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
      },
    },
  },
  config = function()
    require("neodev").setup({})
    require("mason").setup({
      ui = {
        border = "rounded",
        keymaps = {
          apply_language_filter = "Ñ",
        },
      },
    })

    require("mason-lspconfig").setup({})

    ---- Initialize servers
    local lsp = require("lspconfig")
    local cfg = require("config.lsp")

    lsp.astro.setup(cfg)
    lsp.bashls.setup(cfg)
    lsp.clangd.setup(cfg)
    lsp.cmake.setup(cfg)
    lsp.cssls.setup(cfg)
    lsp.dockerls.setup(cfg)
    lsp.elixirls.setup(cfg)
    lsp.emmet_language_server.setup(cfg)
    lsp.gopls.setup(cfg)
    lsp.html.setup(cfg)
    lsp.marksman.setup(cfg)
    lsp.pyright.setup(cfg)
    lsp.rubocop.setup(cfg)
    lsp.ruby_ls.setup(cfg)
    lsp.rust_analyzer.setup(cfg)
    lsp.svelte.setup(cfg)
    lsp.taplo.setup(cfg)
    lsp.tsserver.setup(cfg)
    lsp.zls.setup(cfg)

    lsp.jsonls.setup(vim.tbl_deep_extend("force", cfg, {
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
    }))

    lsp.lua_ls.setup(vim.tbl_deep_extend("force", cfg, {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = {
            disable = { "missing-fields" },
            unusedLocalExclude = { "_*" }, -- Don't warn about variables that start with underscore
          },
          telemetry = {
            enable = false,
          },
          workspace = {
            -- library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
        },
      },
    }))

    lsp.solargraph.setup(vim.tbl_deep_extend("force", cfg, {
      settings = {
        solargraph = {
          diagnostics = false, -- Use rubocop LSP directly
          autoformat = false,
          formatting = false,
          useBundler = true,
        },
      },
    }))

    ----Rust
    require("rust-tools").setup({
      server = {
        on_attach = cfg.on_attach,
        capabilities = cfg.capabilities,
        standalone = false,
        settings = {
          -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
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
                "-W clippy::pedantic",
                "-A clippy::missing-errors-doc",
                "-A clippy::missing-panics-doc",
                "-A clippy::must-use-candidate",
                "-A clippy::needless_range_loop",
              },
            },
          },
        },
        cmd = {
          "rustup",
          "run",
          "stable",
          "rust-analyzer",
        },
      },
      -- dap = {
      --   adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      -- },
    })

    ----fuzzy ruby server
    local lsp_config = require("lspconfig.configs")

    if not lsp_config.fuzzy_ls then
      lsp_config.fuzzy_ls = {
        default_config = {
          cmd = { "fuzzy" },
          filetypes = { "ruby" },
          root_dir = function(fname)
            return lsp.util.find_git_ancestor(fname)
          end,
          settings = {},
          init_options = {
            allocationType = "ram",
            indexGems = true,
            reportDiagnostics = false,
          },
        },
      }
    else
      vim.notify("fuzzy_ls has a config now!!", vim.log.levels.WARN)
    end

    lsp.fuzzy_ls.setup(cfg)
  end,
}
