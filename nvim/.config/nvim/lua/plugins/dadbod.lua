return {
  "tpope/vim-dadbod",
  cmd = {
    "DB",
  },
  init = function()
    vim.keymap.set("n", "d<space>", ":DB<space>")
  end,
}
