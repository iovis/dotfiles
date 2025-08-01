set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @continuum-restore 'on'
set -g @continuum-save-interval '5'

set -g @plugin 'tmux-plugins/tmux-cpu'
set -g @cpu_low_fg_color "#[fg=#51576d]"
set -g @cpu_medium_fg_color "#[fg=#e5c890]"
set -g @cpu_high_fg_color "#[fg=#e78284]"

set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-dir '~/.config/tmux/resurrect'
set -g @resurrect-processes 'lazygit'
set -g @resurrect-strategy-nvim 'session'

set -g @plugin 'tmux-plugins/tmux-yank'
set -g @copy_mode_put 'Space'
set -g @yank_selection_mouse 'clipboard'

set -g @plugin 'tmux-plugins/tpm'
if "test -d ~/.config/tmux/plugins/tpm" {
  run "~/.config/tmux/plugins/tpm/tpm"
} {
  run "git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm && ~/.config/tmux/plugins/tpm/bin/install_plugins"
}

if "type muxi" {
  run -b "muxi init"
}
