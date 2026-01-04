return {
  "hat0uma/csvview.nvim",
  config = function()
    require("csvview").setup({
      view = {
        min_column_width = 3,
        display_mode = "border",
      },
      keymaps = {
        textobject_field_inner = { "ij", mode = { "o", "x" } },
        textobject_field_outer = { "aj", mode = { "o", "x" } },
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    })
  end,
}
