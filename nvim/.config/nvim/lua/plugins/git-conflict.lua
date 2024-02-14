return {
  "akinsho/git-conflict.nvim",
  event = "VeryLazy",
  version = "*",
  config = function()
    require("git-conflict").setup({})
  end,
}
