set -g allow-passthrough on
set -g detach-on-destroy off
set -g display-panes-time 4000
set -g display-time 4000
set -g focus-events on
set -g history-limit 50000
set -g mouse on
set -g set-clipboard on
set -g status-keys emacs
set -g visual-activity off

set -wg mode-keys vi
set -wg monitor-activity on

set -sa terminal-overrides ",$TERM:RGB"
set -sg default-terminal "$TERM"
set -sg escape-time 0
