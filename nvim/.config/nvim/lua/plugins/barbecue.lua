return {
  "utilyre/barbecue.nvim",
  -- cond = vim.g.full_catppuccin,
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    theme = "catppuccin",
    show_dirname = true,
    show_modified = true,
  },
}
