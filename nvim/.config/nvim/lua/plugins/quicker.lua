return {
  "stevearc/quicker.nvim",
  config = function()
    local quicker = require("quicker")

    quicker.setup({
      borders = { vert = " " },
      constrain_cursor = true,
      keys = {
        { "<leader>w", "<cmd>write<cr>" },
      },
      opts = {
        number = true,
        relativenumber = true,
      },
      type_icons = {
        E = "",
        W = "",
        I = "",
        N = "",
        H = "",
      },
      max_filename_width = function()
        return math.floor(math.min(95, vim.o.columns / 4))
      end,
    })
  end,
}
