return {
  "catppuccin/nvim",
  -- enabled = false,
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = not vim.g.full_catppuccin,
      dim_inactive = {
        enabled = false,
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        harpoon = true,
        leap = true,
        lsp_saga = false,
        mason = true,
        mini = true,
        neotree = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      },
      -- NOTE: May need to re-compile after changing
      custom_highlights = function(colors)
        -- lua=require("catppuccin.palettes").get_palette()

        local custom_highlights = {
          -- general
          StatusLine = { bg = colors.base },

          -- fzf-lua (pane color controlled in fish)
          FzfLuaBorder = { fg = colors.blue },

          -- lspsaga
          CodeActionNumber = { fg = colors.teal },
          CodeActionText = { fg = colors.blue },
          DiagnosticSource = { link = "Comment" },
          LspSagaLightBulb = { fg = colors.yellow },

          -- mini
          MiniIndentscopeSymbol = { fg = colors.surface0 },
        }

        if not vim.g.full_catppuccin then
          custom_highlights = vim.tbl_extend("force", custom_highlights, {
            -- general
            EndOfBuffer = {},
            StatusLine = {},
            StatusLineNC = {},
            CursorLine = { bg = "#222222" },

            -- neotree
            NeoTreeStatusLine = {},
            NeoTreeStatusLineNC = {},
            NeoTreeCursorLine = { bold = true },

            -- treesitter
            TreesitterContext = { bg = "#222222", bold = true },
          })
        end

        return custom_highlights
      end,
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
