return {
  "ggandor/leap.nvim",
  -- enabled = false,
  event = "VeryLazy",
  config = function()
    local leap = require("leap")

    leap.setup({})

    vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>(leap-backward-to)")

    leap.add_repeat_mappings(";", ",")
  end,
}
