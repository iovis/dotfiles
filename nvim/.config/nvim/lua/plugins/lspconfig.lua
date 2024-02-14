return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          keymaps = {
            apply_language_filter = "Ñ",
          },
        },
      })

      vim.keymap.set("n", "<leader>lu", "<cmd>Mason<cr>")
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    enabled = vim.fn.has("nvim-0.10") == 1, -- TODO: nvim v0.10
    version = "^3",
    ft = { "rust" },
  },
  {
    "simrat39/rust-tools.nvim",
    enabled = vim.fn.has("nvim-0.10") ~= 1,
  }, -- TODO: Remove in nvim v0.10
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
      lsp.emmet_language_server.setup(cfg)
      lsp.eslint.setup(cfg)
      lsp.gopls.setup(cfg)
      lsp.html.setup(cfg)
      lsp.htmx.setup(cfg)
      lsp.marksman.setup(cfg)
      lsp.pyright.setup(cfg)
      lsp.rubocop.setup(cfg)
      lsp.ruby_ls.setup(cfg)
      lsp.stylelint_lsp.setup(cfg)
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
      if vim.fn.has("nvim-0.10") == 1 then
        vim.g.rustaceanvim = {
          server = {
            on_attach = cfg.on_attach,
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
      else
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
          -- dap = {
          --   adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
          -- },
        })
      end

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

      ---- Global LSP settings
      vim.keymap.set("n", "<leader>lh", "<cmd>help lspconfig-server-configurations<cr>")
      vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
      vim.keymap.set("n", "<leader>lR", ":LspRestart<cr>")

      -- TODO: v0.10 vim.lsp.get_clients()
      vim.api.nvim_create_user_command("LspActiveClients", "R=vim.lsp.get_active_clients()", {})
    end,
  },
}
