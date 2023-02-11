return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
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
      custom_highlights = function(colors)
        return {
          EndOfBuffer = {}, -- doesn't seem to work?
          MiniIndentscopeSymbol = { fg = colors.surface0 },
        }
      end,
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
