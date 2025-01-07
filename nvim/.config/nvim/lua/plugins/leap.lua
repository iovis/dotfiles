return {
  "ggandor/leap.nvim",
  config = function()
    vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>(leap-backward-to)")
  end,
}
