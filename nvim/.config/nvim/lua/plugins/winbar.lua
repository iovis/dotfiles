return {
  "ramilito/winbar.nvim",
  enabled = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("winbar").setup({
      icons = true,
      diagnostics = false,
      buf_modified = true,
      buf_modified_symbol = "●",
      dim_inactive = {
        enabled = true,
      },
      filetype_exclude = {
        "neo-tree",
        "toggleterm",
        "qf",
      },
    })
  end,
}
