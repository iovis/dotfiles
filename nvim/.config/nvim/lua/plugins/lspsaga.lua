return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({
      beacon = {
        enable = false,
      },
      definition = {
        width = 0.8,
        height = 0.6,
        keys = {
          edit = "M",
          vsplit = "<leader>v",
          split = "<leader>h",
          tabe = "<leader>t",
          quit = "q",
        },
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
