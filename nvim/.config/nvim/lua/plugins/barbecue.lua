-- TODO: Try dropbar.nvim on v0.10
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
    -- :=vim.o.winbar
    require("barbecue").setup({
      show_dirname = false,
      show_modified = true,
      attach_navic = false,
      show_navic = true, -- LSP location
      theme = "catppuccin",
      symbols = {
        separator = "›",
      },
      exclude_filetypes = {
        "dbui",
        "netrw",
        "toggleterm",
      },
    })

    vim.keymap.set("n", "yoB", require("barbecue.ui").toggle, { desc = "Toggle barbecue" })
  end,
}
