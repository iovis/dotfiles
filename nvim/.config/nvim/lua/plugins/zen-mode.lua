return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>" },
  },
  opts = {
    window = {
      backdrop = 1,
      height = 0.9,
      width = 0.9,
      options = {
        -- vim.wo options
        cursorcolumn = false,
        cursorline = false,
        list = false,
        number = false,
        relativenumber = false,
        signcolumn = "no",
      },
    },
  },
}
