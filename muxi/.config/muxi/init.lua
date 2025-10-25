-- muxi.print(muxi)

return {
  use_current_pane_path = true,
  plugins = {
    "tmux-plugins/tmux-continuum",
    "tmux-plugins/tmux-cpu",
    "tmux-plugins/tmux-resurrect",
    "tmux-plugins/tmux-yank",
  },
  editor = {
    args = { "+ZenMode", "-c", "nmap q <cmd>silent wqa<cr>" },
  },
  fzf = { input = false },
}
