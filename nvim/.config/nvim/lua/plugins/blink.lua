return {
  "saghen/blink.cmp",
  -- enabled = false,
  -- version = "*",
  build = "cargo build --release",
  dependencies = { "L3MON4D3/LuaSnip" },
  config = function()
    require("blink.cmp").setup({
      keymap = {
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<C-j>"] = { "snippet_forward", "fallback" },
        ["<C-k>"] = { "snippet_backward", "fallback" },
        -- ["<Esc>"] = { "cancel", "fallback" },
        ["<C-b>"] = { "show", "hide" },
        ["<M-d>"] = { "show_documentation", "hide_documentation" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<M-k>"] = { "scroll_documentation_up", "fallback" },
        ["<M-j>"] = { "scroll_documentation_down", "fallback" },
        ["<C-s>"] = {
          function(cmp)
            cmp.show({ providers = { "luasnip" } })
          end,
        },
        ["<M-1>"] = {
          function(cmp)
            cmp.accept({ index = 1 })
          end,
        },
        ["<M-2>"] = {
          function(cmp)
            cmp.accept({ index = 2 })
          end,
        },
        ["<M-3>"] = {
          function(cmp)
            cmp.accept({ index = 3 })
          end,
        },
        ["<M-4>"] = {
          function(cmp)
            cmp.accept({ index = 4 })
          end,
        },
        ["<M-5>"] = {
          function(cmp)
            cmp.accept({ index = 5 })
          end,
        },
        ["<M-6>"] = {
          function(cmp)
            cmp.accept({ index = 6 })
          end,
        },
        ["<M-7>"] = {
          function(cmp)
            cmp.accept({ index = 7 })
          end,
        },
        ["<M-8>"] = {
          function(cmp)
            cmp.accept({ index = 8 })
          end,
        },
        ["<M-9>"] = {
          function(cmp)
            cmp.accept({ index = 9 })
          end,
        },

        -- cmdline = {
        --   -- TODO:
        --   --   - <c-b> not mappable?
        --   --   - <esc> executes the command (neovim issue)
        --   ["<C-y>"] = { "select_and_accept" },
        --   ["<Tab>"] = { "select_next", "fallback" },
        --   ["<S-Tab>"] = { "select_prev", "fallback" },
        --   ["<C-n>"] = { "select_next", "fallback" },
        --   ["<C-p>"] = { "select_prev", "fallback" },
        --   ["<C-s>"] = { "cancel", "fallback" },
        --   ["<M-1>"] = {
        --     function(cmp)
        --       cmp.accept({ index = 1 })
        --     end,
        --   },
        --   ["<M-2>"] = {
        --     function(cmp)
        --       cmp.accept({ index = 2 })
        --     end,
        --   },
        --   ["<M-3>"] = {
        --     function(cmp)
        --       cmp.accept({ index = 3 })
        --     end,
        --   },
        --   ["<M-4>"] = {
        --     function(cmp)
        --       cmp.accept({ index = 4 })
        --     end,
        --   },
        --   ["<M-5>"] = {
        --     function(cmp)
        --       cmp.accept({ index = 5 })
        --     end,
        --   },
        --   ["<M-6>"] = {
        --     function(cmp)
        --       cmp.accept({ index = 6 })
        --     end,
        --   },
        --   ["<M-7>"] = {
        --     function(cmp)
        --       cmp.accept({ index = 7 })
        --     end,
        --   },
        --   ["<M-8>"] = {
        --     function(cmp)
        --       cmp.accept({ index = 8 })
        --     end,
        --   },
        --   ["<M-9>"] = {
        --     function(cmp)
        --       cmp.accept({ index = 9 })
        --     end,
        --   },
        -- },
      },

      completion = {
        list = {
          selection = "auto_insert",
        },

        menu = {
          border = "rounded",
          scrollbar = false,
          draw = {
            columns = {
              { "item_idx" }, -- Show index of completion
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
            components = {
              item_idx = {
                highlight = "BlinkCmpItemIdx",
                text = function(ctx)
                  return ctx.idx >= 10 and " " or tostring(ctx.idx)
                end,
              },

              source_name = {
                width = { max = 4 },
                ellipsis = false,
              },
            },
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          window = {
            border = "rounded",
            scrollbar = false,
          },
        },

        ghost_text = { enabled = true },
      },

      -- Experimental
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },

      sources = {
        default = { "lsp", "path", "luasnip", "buffer" },
        -- cmdline = {},
      },

      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,

        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end

          return require("luasnip").in_snippet()
        end,

        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
    })

    vim.api.nvim_create_user_command("BlinkReload", function()
      require("blink.cmp").reload()
      vim.notify("Blink reloaded")
    end, {})
  end,
}
