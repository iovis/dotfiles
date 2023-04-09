return {
  "utilyre/barbecue.nvim",
  -- enabled = false,
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("barbecue").setup({
      show_dirname = false,
      show_modified = true,
      show_navic = true, -- LSP location
      theme = "catppuccin",
    })

    -- require("barbecue.ui").toggle(false)

    vim.keymap.set("n", "+b", require("barbecue.ui").toggle, { desc = "Toggle barbecue" })
  end,
}
