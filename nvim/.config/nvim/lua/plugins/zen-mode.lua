return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>" },
  },
  config = {
    window = {
      backdrop = 1,
      height = 0.9,
      width = 0.8,
      options = {
        -- Any vim.wo options
        signcolumn = "no",
        number = false,
        relativenumber = false,
      },
    },
  },
}
