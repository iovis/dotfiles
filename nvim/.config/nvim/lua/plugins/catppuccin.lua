return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      transparent_background = true,
      float = { transparent = true },
      no_italic = true,
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

          -- Blink.cmp
          BlinkCmpMenuSelection = { bg = colors.base },
          BlinkCmpItemIdx = { fg = colors.peach, bold = true },

          -- Bqf
          BqfPreviewBufLabel = { fg = colors.yellow, bold = true },

          -- Cmp
          CmpItemMenu = { link = "Comment" },

          -- Diff
          ["@diff.plus"] = { fg = colors.green, bold = true },
          ["@diff.delta"] = { fg = colors.blue, bold = true },
          ["@diff.minus"] = { fg = colors.red, bold = true },

          -- LSP Document Highlights
          LspReferenceRead = { bg = colors.base },
          LspReferenceText = { bg = colors.base },
          LspReferenceWrite = { bg = colors.base },

          -- lspsaga
          CodeActionNumber = { fg = colors.teal },
          CodeActionText = { fg = colors.blue },
          DiagnosticSource = { link = "Comment" },
          SagaLightBulb = { fg = colors.yellow },

          -- markdown
          ["@markup.quote"] = { link = "Comment" },
          MarkviewInlineCode = { bg = colors.crust },

          -- matchup
          MatchParen = { bg = colors.mantle, fg = colors.peach, bold = true },
          MatchWord = { bold = true },

          -- neotree
          NeoTreeCursorLine = { bold = true },

          -- noice
          NotifyBackground = { fg = colors.text, bg = colors.base },
          NoiceMini = { fg = colors.text, bg = colors.base },

          -- quickfix
          QuickFixLine = { bg = colors.base, bold = true },

          -- statuscolumn
          VisualLineNr = { fg = colors.peach, bold = true },

          -- treesitter
          TreesitterContext = { bg = black, bold = true },
          TreesitterContextBottom = { style = {} }, -- Disable underline
          TreesitterContextLineNumber = { fg = colors.surface1, bg = black, bold = true },
          ["@module"] = { style = {} },
          ["@namespace"] = { style = {} },

          -- winbar
          WinBar = { fg = colors.text, bold = true },
          WinBarNC = { link = "Comment" },

          -- "TODO" highlights
          ["@lsp.type.comment"] = {}, -- Disable LSP semantic tokens
          ["@comment.todo"] = { link = "DiagnosticWarn" },
          ["@comment.note"] = { link = "DiagnosticInfo" },
          ["@comment.warning"] = { link = "DiagnosticWarn" },
          ["@comment.error"] = { link = "DiagnosticError" },
        }
      end,
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")

    vim.api.nvim_create_user_command("CatppuccinPalette", function()
      vim.cmd("30R! =require('catppuccin.palettes').get_palette()")
      vim.cmd("ColorizerToggle")
    end, {})
  end,
}
