return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  config = function()
    require("bqf").setup({
      func_map = {
        pscrolldown = "<m-j>",
        pscrollorig = "<m-;>",
        pscrollup = "<m-k>",
        ptoggleauto = "<m-p>",
        ptoggleitem = "",
        split = "<c-s>",
        tab = "<c-t>",
      },
      preview = {
        winblend = 0,
      },
    })
  end,
}
