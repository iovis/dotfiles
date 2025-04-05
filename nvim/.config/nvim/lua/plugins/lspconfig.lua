return {
  { "b0o/schemastore.nvim", lazy = true },
  { "mrcjkb/rustaceanvim", lazy = false, version = "*" },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
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
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lsp")
      local lsp = require("lspconfig")

      -- vim.lsp.set_log_level("debug")

      lsp.bashls.setup({})
      lsp.clangd.setup({})
      lsp.cmake.setup({})
      lsp.cssls.setup({})
      lsp.dockerls.setup({})
      lsp.emmet_language_server.setup({})
      lsp.gopls.setup({})
      lsp.marksman.setup({})
      lsp.ruby_lsp.setup({})
      lsp.sourcekit.setup({ filetypes = { "swift" } })
      lsp.svelte.setup({})
      lsp.taplo.setup({})
      lsp.zls.setup({})

      lsp.html.setup({
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

      lsp.jsonls.setup({
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

      lsp.lua_ls.setup({
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

      lsp.solargraph.setup({
        settings = {
          solargraph = {
            diagnostics = false,
            autoformat = false,
            formatting = false,
            -- useBundler = true,
          },
        },
      })

      lsp.ts_ls.setup({
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

      lsp.yamlls.setup({
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

      ---@module "rustaceanvim"
      ---@type rustaceanvim.Opts
      vim.g.rustaceanvim = {
        server = {
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
      vim.keymap.set("n", "<leader>lR", ":LspRestart<cr>")
      vim.keymap.set("n", "<leader>lh", "<cmd>help lspconfig-all<cr>")
      vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
      vim.keymap.set("n", "<leader>ll", "<cmd>LspLog<cr>")

      vim.api.nvim_create_user_command("LspActiveClients", "R=vim.lsp.get_clients()", {})
    end,
  },
}
