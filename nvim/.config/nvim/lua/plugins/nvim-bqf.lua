return {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",
  dependencies = {
    "junegunn/fzf",
  },
  config = function()
    require("bqf").setup({
      filter = {
        fzf = {
          extra_opts = {
            "--bind",
            "ctrl-p:page-up,ctrl-n:page-down,alt-a:select-all,alt-d:deselect-all,alt-t:toggle-all",
          },
        },
      },
      func_map = {
        ptoggleauto = "p",
      },
      preview = {
        winblend = 0,
      },
    })
  end,
}
