return {
  "ggandor/leap.nvim",
  event = "VeryLazy",
  config = function()
    local leap = require("leap")

    leap.setup({})

    vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>(leap-backward-to)")
    vim.keymap.set({ "x", "o" }, "t", "<Plug>(leap-forward-till)")
    vim.keymap.set({ "x", "o" }, "T", "<Plug>(leap-backward-till)")

    leap.add_repeat_mappings(";", ",")
  end,
}
