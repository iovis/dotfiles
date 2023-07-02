return {
  "ggandor/leap.nvim",
  -- enabled = false,
  event = "VeryLazy",
  config = function()
    require("leap").setup({})

    vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>(leap-backward-to)")
  end,
}
