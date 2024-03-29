set -g allow-passthrough on
set -g detach-on-destroy off
set -g display-panes-time 4000
set -g display-time 4000
set -g focus-events on
set -g history-limit 100000
set -g mouse on
set -g set-clipboard on
set -g status-keys emacs
set -g visual-activity off
set -g remain-on-exit off # failed

set -wg mode-keys vi
set -wg monitor-activity on

set -sg default-terminal "tmux-256color"
set -sa terminal-features ",xterm-256color:RGB"
set -sg escape-time 0
