return {
  "OXY2DEV/markview.nvim",
  config = function()
    require("markview").setup({
      block_quote = {
        default = { border = "│" },
      },
      checkbox = {
        checked = { marker = "[✔]" },
        uncheked = { marker = "[✘]" },
      },
    })
  end,
}
