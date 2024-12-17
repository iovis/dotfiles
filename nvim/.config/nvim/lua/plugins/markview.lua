return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  config = function()
    require("markview").setup({
      initial_state = false,
      modes = { "n", "i", "nc", "c" },
      hybrid_modes = { "i" },
      block_quotes = {
        default = { border = "│" },
      },
      checkboxes = {
        checked = { text = "[✔]" },
        unchecked = { text = "[✘]" },
      },
      headings = { shift_width = 2 },
      list_items = { enable = false },
    })
  end,
}
