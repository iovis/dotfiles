return {
  "iovis/resize.vim",
  keys = {
    { "<m-up>", "<Plug>ResizeUp" },
    { "<m-down>", "<Plug>ResizeDown" },
    { "<m-left>", "<Plug>ResizeLeft" },
    { "<m-right>", "<Plug>ResizeRight" },
  },
  config = function()
    vim.g.resize_vim_horizontal = 20
    vim.g.resize_vim_vertical = 5
  end,
}
