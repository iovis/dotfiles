return {
  "catppuccin/nvim",
  -- enabled = false,
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
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
        local none = "#181818"

        return {
          -- general
          EndOfBuffer = { fg = none },
          StatusLine = { bg = colors.surface0 },
          StatusLineNC = { bg = colors.base },
          CursorLine = { bg = "#1e1e1e" },

          -- fzf-lua
          FzfLuaBorder = { fg = colors.blue },

          -- lspsaga
          CodeActionNumber = { fg = colors.teal },
          CodeActionText = { fg = colors.blue },
          DiagnosticSource = { link = "Comment" },
          LspSagaLightBulb = { fg = colors.yellow },

          -- mini
          MiniIndentscopeSymbol = { fg = colors.surface0 },

          -- neotree
          NeoTreeStatusLine = { bg = none },
          NeoTreeStatusLineNC = { bg = none },

          -- treesitter
          TreesitterContext = { bg = colors.base, bold = true },
        }
      end,
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}