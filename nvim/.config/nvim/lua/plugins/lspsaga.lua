return {
  "glepnir/lspsaga.nvim",
  config = function()
    require("lspsaga").init_lsp_saga({
      border_style = "rounded",
      code_action_icon = "",
      code_action_lightbulb = {
        enable = true,
        cache_code_action = false,
        enable_in_insert = false,
        sign = false,
      },
      finder_action_keys = {
        auto_refresh = false,
        open = "<cr>",
      },
      show_outline = {
        jump_key = "<cr>",
      },
      symbol_in_winbar = {
        enable = false,
      },
    })
  end,
}
