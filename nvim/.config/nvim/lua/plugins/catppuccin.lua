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
      transparent_background = not vim.g.full_catppuccin,
      dim_inactive = {
        enabled = vim.g.full_catppuccin,
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
        noice = true,
        notify = true,
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

          -- noice
          NotifyBackground = { fg = colors.text, bg = colors.base },
        }

        if not vim.g.full_catppuccin then
          -- colors.crust = hsl(229, 20, 17) => black = hsl(229, 20, 15)
          local black = "#1f212e"

          custom_highlights = vim.tbl_extend("force", custom_highlights, {
            -- general
            CursorLine = { bg = black },
            EndOfBuffer = {},
            StatusLine = {},
            StatusLineNC = {},
            Visual = { bg = colors.surface0, bold = true },

            -- neotree
            NeoTreeStatusLine = {},
            NeoTreeStatusLineNC = {},
            NeoTreeCursorLine = { bold = true },

            -- treesitter
            TreesitterContext = { bg = black, bold = true },
            TreesitterContextLineNumber = { fg = colors.surface1, bg = black, bold = true },
          })
        end

        return custom_highlights
      end,
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
