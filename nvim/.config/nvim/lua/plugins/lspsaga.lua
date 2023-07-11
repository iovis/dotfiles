return {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  -- commit = "4f07545", -- pre v0.3
  config = function()
    require("lspsaga").setup({
      beacon = {
        enable = false,
      },
      diagnostic = {
        keys = {
          exec_action = "<cr>",
        },
      },
      finder = {
        -- TODO: Implementation seems broken?
        keys = {
          toggle_or_open = "<cr>",
        },
      },
      lightbulb = {
        enable = true,
        enable_in_insert = false,
        sign = false,
      },
      outline = {
        keys = {
          toggle_or_jump = "<cr>",
        },
      },
      rename = {
        auto_save = true,
        keys = {
          quit = "<esc>",
        },
      },
      symbol_in_winbar = {
        enable = false,
      },
      ui = {
        border = "rounded",
        code_action = " ",
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        lines = { "└", "├", "│", "─", "┌" },
      },
    })
  end,
}
