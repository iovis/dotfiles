return {
  "saghen/blink.cmp",
  enabled = false,
  -- version = "*",
  build = "cargo build --release",
  dependencies = { "L3MON4D3/LuaSnip" },
  config = function()
    require("blink.cmp").setup({
      keymap = {
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<C-j>"] = { "snippet_forward", "fallback" },
        ["<C-k>"] = { "snippet_backward", "fallback" },
        ["<Esc>"] = { "cancel", "fallback" },
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
        cmdline = {
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-b>"] = { "cancel", "fallback" }, -- Not working?
          -- ["<esc>"] = { "cancel", "fallback" }, -- Seems to cause issues by executing the command
        },
      },

      completion = {
        list = {
          selection = "auto_insert",
        },
        menu = {
          border = "rounded",
          scrollbar = false,
        },
        documentation = {
          auto_show = false,
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

    vim.keymap.set("n", "<leader>sb", function()
      require("blink.cmp").reload()
      vim.notify("Blink reloaded")
    end, { desc = "Reload blink.cmp" })
  end,
}
