local M = {
  "ggandor/leap.nvim",
  event = "VeryLazy",
}

function M.config()
  local ok, leap = pcall(require, "leap")
  if not ok then
    print("leap not found!")
    return
  end

  leap.setup({})

  vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(leap-forward-to)")
  vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>(leap-backward-to)")
end

return M
