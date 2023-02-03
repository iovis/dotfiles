return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    { "U", ":UndotreeToggle<cr>" },
  },
  init = function()
    vim.g.undotree_SetFocusWhenToggle = true
    vim.g.undotree_ShortIndicators = true
  end,
}
