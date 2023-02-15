return {
  "utilyre/barbecue.nvim",
  -- cond = vim.g.full_catppuccin,
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    theme = "catppuccin",
    show_dirname = false,
    show_modified = true,
  },
}
