return {
  "folke/twilight.nvim",
  cmd = { "Twilight" },
  keys = {
    { "yoz", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
  },
  config = function()
    require("twilight").setup({
      -- context = 0,
      expand = {
        -- Default
        "function",
        "method",
        "table",
        "if_statement",
        -- Custom
        "Decl", -- zig
        "Block", -- zig
      },
    })
  end,
}
