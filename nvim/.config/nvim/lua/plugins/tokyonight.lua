return {
  "folke/tokyonight.nvim",
  -- enabled = false,
  event = "VeryLazy",
  -- lazy = false,
  -- priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "moon", -- storm | moon | night | day
      transparent = true,
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      -- styles = {
      --   -- Style to be applied to different syntax groups
      --   -- Value is any valid attr-list value for `:help nvim_set_hl`
      --   comments = { italic = true },
      --   keywords = { italic = true },
      --   functions = {},
      --   variables = {},
      --   -- Background styles. Can be "dark", "transparent" or "normal"
      --   sidebars = "dark", -- style for sidebars, see below
      --   floats = "dark", -- style for floating windows
      -- },
      sidebars = {}, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      -- hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = true, -- dims inactive windows

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      -- on_colors = function(colors) end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param hi Highlights
      ---@param colors ColorScheme
      on_highlights = function(hi, colors)
        local background = "#181818"

        -- general
        hi.EndOfBuffer = { fg = background }

        -- lspsaga
        -- hi.CodeActionNumber = { fg = colors.teal }
        -- hi.CodeActionText = { fg = colors.blue }
        hi.LspSagaLightBulb = { fg = colors.yellow }

        -- mini
        hi.MiniIndentscopeSymbol = { fg = colors.dark3 }
      end,
    })

    -- setup must be called before loading
    -- vim.cmd.colorscheme("tokyonight")
  end,
}
