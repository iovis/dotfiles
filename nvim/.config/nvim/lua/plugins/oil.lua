return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")

    oil.setup({
      default_file_explorer = false,
      float = {
        max_width = 75,
        max_height = 20,
        win_options = {
          winblend = 0,
        },
      },
      keymaps = {
        ["<c-r>"] = "actions.refresh",
      },
      view_options = {
        show_hidden = true,
      },
    })

    vim.keymap.set("n", "-", oil.open_float, { desc = "Open parent directory" })
  end,
}
