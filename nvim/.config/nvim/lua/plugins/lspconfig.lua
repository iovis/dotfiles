return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          keymaps = {
            apply_language_filter = ";",
          },
        },
      })

      vim.keymap.set("n", "<leader>lu", "<cmd>Mason<cr>")
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    lazy = false,
    version = "^4",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/schemastore.nvim",
      "williamboman/mason.nvim",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
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
      lsp.eslint.setup(cfg)
      lsp.gopls.setup(cfg)
      lsp.htmx.setup(cfg)
      lsp.marksman.setup(cfg)
      lsp.pyright.setup(cfg)
      lsp.rubocop.setup(cfg)
      lsp.stylelint_lsp.setup(cfg)
      lsp.svelte.setup(cfg)
      lsp.taplo.setup(cfg)
      lsp.templ.setup(cfg)
      lsp.tsserver.setup(cfg)
      lsp.zls.setup(cfg)

      lsp.emmet_language_server.setup(vim.tbl_deep_extend("force", cfg, {
        filetypes = {
          "css",
          "eruby",
          "html",
          "htmldjango",
          "javascriptreact",
          "less",
          "pug",
          "sass",
          "scss",
          "templ",
          "typescriptreact",
        },
      }))

      lsp.html.setup(vim.tbl_deep_extend("force", cfg, {
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
          "templ",
        },
      }))

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
      }))

      lsp.ruby_lsp.setup(vim.tbl_deep_extend("force", cfg, {
        init_options = {
          enabledFeatures = {
            -- "codeActions",
            -- "diagnostics",
            "documentHighlights",
            "documentSymbols",
            -- "formatting",
            "inlayHint",
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

      lsp.sourcekit.setup(vim.tbl_deep_extend("force", cfg, {
        filetypes = { "swift" },
      }))

      lsp.yamlls.setup(vim.tbl_deep_extend("force", cfg, {
        settings = {
          yaml = {
            schemas = require("schemastore").yaml.schemas(),
            schemaStore = {
              enable = false,
              url = "",
            },
          },
        },
      }))

      vim.g.rustaceanvim = {
        server = {
          on_attach = cfg.on_attach,
          capabilities = cfg.capabilities,
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
        },
      }

      ---- Global LSP settings
      vim.keymap.set("n", "<leader>lh", "<cmd>help lspconfig-server-configurations<cr>")
      vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
      vim.keymap.set("n", "<leader>lR", ":LspRestart<cr>")

      vim.api.nvim_create_user_command("LspActiveClients", "R=vim.lsp.get_clients()", {})
    end,
  },
}
