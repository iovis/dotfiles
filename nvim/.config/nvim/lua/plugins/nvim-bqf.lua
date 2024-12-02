return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  dependencies = {
    { "junegunn/fzf", version = "*" },
    -- { "junegunn/fzf", version = "*", build = "./install --bin" },
  },
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
