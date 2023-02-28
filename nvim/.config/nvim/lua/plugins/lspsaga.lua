return {
  "glepnir/lspsaga.nvim",
  -- dev = true,
  config = function()
    require("lspsaga").setup({
      beacon = {
        enable = false,
      },
      -- code_action = {
      --   extend_gitsigns = false,
      -- },
      diagnostic = {
        on_insert = false,
        keys = {
          exec_action = "<cr>",
        },
      },
      lightbulb = {
        enable = true,
        enable_in_insert = false,
        sign = false,
      },
      outline = {
        keys = {
          jump = "<cr>",
          expand_collapse = "x",
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
