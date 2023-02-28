return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    { "U", ":UndotreeToggle<cr>", silent = true },
  },
  init = function()
    vim.g.undotree_SetFocusWhenToggle = true
    vim.g.undotree_ShortIndicators = true
    vim.g.undotree_WindowLayout = 2
  end,
}
