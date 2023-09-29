set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @continuum-restore 'on'
set -g @continuum-save-interval '5'

set -g @plugin 'tmux-plugins/tmux-cpu'

set -g @plugin 'morantron/tmux-fingers'
set -g @fingers-backdrop-style "fg=colour8"
set -g @fingers-highlight-style "fg=colour111"
set -g @fingers-selected-hint-style "fg=yellow,bold"
set -g @fingers-selected-highlight-style "fg=yellow"
set -g @fingers-pattern-0 '(❯|❮) ((?<match>.+?)(\s{2,}.+$|$))'
set -g @fingers-pattern-1 '(rspec|cucumber) [^:]+:\d+'

set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-dir '~/.config/tmux/resurrect'
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

set -g @muxi-uppercase-overrides 'on'
if "type muxi" {
  run -b "muxi init"
}

bind -n M-- run "muxi fzf"
