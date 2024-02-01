return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  dependencies = {
    { "junegunn/fzf", version = "*" },
  },
  config = function()
    require("bqf").setup({
      func_map = {
        split = "<c-s>",
      },
      preview = {
        winblend = 0,
      },
    })
  end,
}
