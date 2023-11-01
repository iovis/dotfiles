return {
  "folke/twilight.nvim",
  cmd = { "Twilight" },
  keys = {
    { "+T", "<cmd>Twilight<cr>" },
  },
  config = function()
    require("twilight").setup({
      context = 0,
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
