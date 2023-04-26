return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  cmd = "WhichKey",
  keys = {
    { "+r", ':WhichKey "<cr>', desc = "which registers" },
    { "+m", ":WhichKey `<cr>", desc = "which marks" },
  },
  config = function()
    require("which-key").setup({
      triggers = {
        "z",
      },
      plugins = {
        spelling = {
          enabled = true,
        },
      },
      window = {
        border = "rounded",
      },
    })
  end,
}
