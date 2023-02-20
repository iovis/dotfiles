return {
  "utilyre/barbecue.nvim",
  -- enabled = false
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("barbecue").setup({
      show_dirname = true,
      show_modified = true,
      show_navic = true, -- LSP location
      theme = "catppuccin",
    })
  end,
}
