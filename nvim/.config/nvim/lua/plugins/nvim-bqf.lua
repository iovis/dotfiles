return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  config = function()
    require("bqf").setup({
      func_map = {
        split = "<c-s>",
        pscrollup = "<m-k>",
        pscrolldown = "<m-j>",
        pscrollorig = "<m-;>",
      },
      preview = {
        winblend = 0,
      },
    })
  end,
}
