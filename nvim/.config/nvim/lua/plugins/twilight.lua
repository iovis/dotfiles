return {
  "folke/twilight.nvim",
  cmd = { "Twilight" },
  keys = {
    { "+T", "<cmd>Twilight<cr>" },
  },
  config = function()
    require("twilight").setup({})
  end,
}
