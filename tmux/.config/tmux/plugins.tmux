# tmux-continuum
set -g @continuum-restore 'on'
set -g @continuum-save-interval '5'

# tmux-cpu
set -g @cpu_low_fg_color "#[fg=#51576d]"
set -g @cpu_medium_fg_color "#[fg=#e5c890]"
set -g @cpu_high_fg_color "#[fg=#e78284]"

# tmux-resurrect
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-dir '~/.config/tmux/resurrect'
set -g @resurrect-processes 'lazygit'
set -g @resurrect-strategy-nvim 'session'

# tmux-yank
set -g @copy_mode_put 'Space'
set -g @yank_selection_mouse 'clipboard'

if "type muxi" {
  run -b "muxi init"
  run -b "muxi plugins init"
}
