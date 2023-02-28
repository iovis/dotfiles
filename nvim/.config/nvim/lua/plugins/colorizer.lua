return {
  "NvChad/nvim-colorizer.lua",
  -- enabled = false,
  event = "VeryLazy",
  keys = {
    { "+C", "<cmd>ColorizerToggle<cr>", silent = true },
  },
  config = function()
    require("colorizer").setup({
      filetypes = {
        "css",
        "html",
        "scss",
        "svelte",
      },
      user_default_options = {
        names = false,
        RRGGBBAA = true,
        -- mode = "virtualtext",
      },
    })
  end,
}
