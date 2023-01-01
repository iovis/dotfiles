return {
  "tommcdo/vim-lion",
  event = "VeryLazy",
  keys = {
    { "<leader>a,", "mzgLip,'z", remap = true },
    { "<leader>a:", "mzgLip:'z", remap = true },
    { "<leader>a=", "mzglip='z", remap = true },
    { "<leader>aB", "mzglip{'z", remap = true },
  },
  config = function()
    vim.g.lion_squeeze_spaces = 1
  end,
}
