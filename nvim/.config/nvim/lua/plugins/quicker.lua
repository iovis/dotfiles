return {
  "stevearc/quicker.nvim",
  version = "*",
  -- enabled = false,
  config = function()
    local quicker = require("quicker")

    quicker.setup({
      borders = { vert = " " },
      constrain_cursor = true,
      highlight = { lsp = false },
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
        -- return math.floor(math.min(95, vim.o.columns / 4))
        return math.huge
      end,
    })
  end,
}
