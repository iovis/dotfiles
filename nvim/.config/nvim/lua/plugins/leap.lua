local M = {
  "ggandor/leap.nvim",
  event = "VeryLazy",
}

function M.config()
  require("leap").setup({})

  vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(leap-forward-to)")
  vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>(leap-backward-to)")
end

return M
