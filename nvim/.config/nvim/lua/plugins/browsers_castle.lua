return {
  "iovis/browsers_castle",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("x", "go<space>", 'y:Google <c-r>"')
    vim.keymap.set("x", "go<cr>", 'y:Google <c-r>"<cr>')
  end,
}
