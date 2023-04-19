return {
  "catppuccin/nvim",
  -- enabled = false,
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      background = {
        light = "latte",
        dark = "frappe",
      },
      transparent_background = true,
      dim_inactive = {
        enabled = false,
      },
      integrations = {
        cmp = true,
        fidget = false,
        gitsigns = true,
        harpoon = true,
        leap = true,
        lsp_saga = false,
        mason = true,
        mini = true,
        neotree = true,
        noice = false,
        notify = false,
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
      -- lua=require("catppuccin.palettes").get_palette()
      custom_highlights = function(colors)
        -- colors.crust = hsl(229, 20, 17) => black = hsl(229, 20, 15)
        local black = "#1f212e"

        return {
          -- general
          CursorLine = { bg = black },
          EndOfBuffer = {},
          StatusLine = {},
          StatusLineNC = {},
          Visual = { bg = colors.surface0, bold = true },

          -- fzf-lua (pane color controlled in fish)
          FzfLuaBorder = { fg = colors.blue },

          -- lspsaga
          CodeActionNumber = { fg = colors.teal },
          CodeActionText = { fg = colors.blue },
          DiagnosticSource = { link = "Comment" },
          SagaLightBulb = { fg = colors.yellow },

          -- mini
          MiniIndentscopeSymbol = { fg = colors.surface0 },

          -- neotree
          NeoTreeStatusLine = {},
          NeoTreeStatusLineNC = {},
          NeoTreeCursorLine = { bold = true },

          -- noice
          NotifyBackground = { fg = colors.text, bg = colors.base },
          NoiceMini = { fg = colors.text, bg = colors.base },

          -- treesitter
          TreesitterContext = { bg = black, bold = true },
          TreesitterContextLineNumber = { fg = colors.surface1, bg = black, bold = true },
        }
      end,
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
