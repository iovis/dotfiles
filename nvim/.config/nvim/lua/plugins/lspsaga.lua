return {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  config = function()
    require("lspsaga").setup({
      beacon = {
        enable = false,
      },
      -- code_action = {
      --   extend_gitsigns = false,
      -- },
      diagnostic = {
        keys = {
          exec_action = "<cr>",
        },
      },
      finder = {
        keys = {
          expand_or_jump = "<cr>",
        },
      },
      lightbulb = {
        enable = true,
        enable_in_insert = false,
        sign = false,
      },
      outline = {
        keys = {
          expand_or_jump = "<cr>",
        },
      },
      symbol_in_winbar = {
        enable = false,
      },
      ui = {
        border = "rounded",
        code_action = "",
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        -- winblend = 0.5,  -- nvim v0.9.0
      },
    })
  end,
}
