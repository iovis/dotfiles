-- muxi.print(muxi)

return {
  use_current_pane_path = true,
  fzf = { input = false },
  editor = {
    args = { "-c", "nmap q <cmd>silent wqa<cr>" },
  },
  plugins = {
    {
      url = "tmux-plugins/tmux-resurrect",
      opts = {
        ["resurrect-capture-pane-contents"] = "on",
        ["resurrect-processes"] = "lazygit",
        ["resurrect-strategy-nvim"] = "session",
      },
    },
    {
      url = "tmux-plugins/tmux-continuum",
      opts = {
        -- ["continuum-restore"] = "on", -- Seems to cause issues when resurrecting (race condition?)
        ["continuum-save-interval"] = "5",
      },
    },
    {
      url = "tmux-plugins/tmux-cpu",
      opts = {
        cpu_low_fg_color = "#[fg=#51576d]",
        cpu_medium_fg_color = "#[fg=#e5c890]",
        cpu_high_fg_color = "#[fg=#e78284]",
      },
    },
    {
      url = "tmux-plugins/tmux-yank",
      opts = {
        copy_mode_put = "Space",
        yank_selection_mouse = "clipboard",
      },
    },
  },
}
