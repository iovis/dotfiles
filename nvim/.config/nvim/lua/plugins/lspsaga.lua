return {
  "glepnir/lspsaga.nvim",
  config = function()
    require("lspsaga").setup({
      diagnostic = {
        keys = {
          exec_action = "<cr>",
        },
      },
      finder_action_keys = {
        auto_refresh = false,
        open = "<cr>",
      },
      lightbulb = {
        enable = true,
        cache_code_action = false,
        enable_in_insert = false,
        sign = false,
      },
      show_outline = {
        jump_key = "<cr>",
      },
      symbol_in_winbar = {
        enable = false,
      },
      ui = {
        border = "rounded",
        code_action = "",
      },
    })
  end,
}
