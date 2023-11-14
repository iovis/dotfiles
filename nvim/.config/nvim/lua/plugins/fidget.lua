return {
  "j-hui/fidget.nvim",
  event = "VeryLazy",
  config = function()
    require("fidget").setup({
      notification = {
        window = {
          winblend = 0,
        }
      }
    })
  end,
}
