return {
  "stevearc/oil.nvim",
  cmd = { "Oil" },
  keys = {
    { "-", "<cmd>Oil --float<cr>" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local oil = require("oil")

    oil.setup({
      default_file_explorer = false,
      float = {
        max_height = 20,
        max_width = 75,
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
  end,
}
