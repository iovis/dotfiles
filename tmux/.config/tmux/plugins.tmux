## Plugin List
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'tmux-plugins/tmux-cpu'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-sessionist'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tpm'

## Config
set -g @continuum-restore 'on'
set -g @continuum-save-interval '5'
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-strategy-nvim 'session'
set -g @resurrect-dir '~/.config/tmux/resurrect'
set -g @sessionist-alternate 'C-Space'
set -g @sessionist-goto 'G'
set -g @yank_selection_mouse 'clipboard'
