return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
  init = function()
    vim.g.tmux_navigator_save_on_switch = 2
  end,
}
