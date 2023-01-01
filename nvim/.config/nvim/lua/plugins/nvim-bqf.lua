return {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",
  init = function()
    local u = require("user.utils")
    u.highlight("BqfSign", { link = "Directory" })
  end,
  config = {
    filter = {
      fzf = {
        extra_opts = {
          "--bind",
          "ctrl-p:page-down,ctrl-n:page-up,alt-a:select-all,alt-d:deselect-all,alt-t:toggle-all",
        },
      },
    },
    func_map = {
      ptoggleauto = "p",
    },
  },
}
