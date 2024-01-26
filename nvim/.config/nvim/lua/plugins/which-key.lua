return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  cmd = "WhichKey",
  config = function()
    require("which-key").setup({
      triggers = {},
      plugins = {
        spelling = {
          enabled = true,
        },
      },
      window = {
        border = "rounded",
      },
    })
  end,
}
