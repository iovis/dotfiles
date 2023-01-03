return {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup({
      plugins = {
        spelling = {
          enabled = true,
        },
      },
      window = {
        border = "single",
      },
      -- layout = {
      --   height = { min = 4, max = 15 },
      -- },
    })
  end,
}
