return {
  "iovis/browsers_castle",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "g<space>", ":Google<space>")
    vim.keymap.set("n", "g<cr>", ":Google <c-r><c-w><cr>")

    vim.keymap.set("x", "g<space>", 'y:Google <c-r>"')
    vim.keymap.set("x", "g<cr>", 'y:Google <c-r>"<cr>')
  end,
}
