return {
  "Wansmer/treesj",
  keys = {
    { "+j", ":TSJJoin<cr>", silent = true },
    { "+s", ":TSJSplit<cr>", silent = true },
  },
  config = function()
    require("treesj").setup({
      use_default_keymaps = true,
    })
  end,
}
