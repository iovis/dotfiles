return {
  "yorickpeterse/nvim-pqf",
  event = "VeryLazy",
  config = function()
    require("pqf").setup({
      show_multiple_lines = false,
      signs = {
        error = { text = "" },
        warning = { text = "" },
        info = { text = "" },
        hint = { text = "" },
      },
    })
  end,
}
