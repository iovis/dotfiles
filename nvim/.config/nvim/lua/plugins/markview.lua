return {
  "OXY2DEV/markview.nvim",
  enabled = false,
  ft = "markdown",
  config = function()
    require("markview").setup({
      block_quotes = {
        default = { border = "│" },
      },
      checkboxes = {
        checked = { text = "[✔]" },
        uncheked = { text = "[✘]" },
      },
    })
  end,
}
