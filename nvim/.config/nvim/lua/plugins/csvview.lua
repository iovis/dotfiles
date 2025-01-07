return {
  "hat0uma/csvview.nvim",
  config = function()
    require("csvview").setup({
      view = { display_mode = "border" },
    })
  end,
}
