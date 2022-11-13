# focus-events on?
set -g allow-passthrough on
set -g default-terminal "screen-256color"
set -g display-panes-time 4000
set -g history-limit 10000
set -g mouse on
set -g set-clipboard on
set -g visual-activity off

set -wg mode-keys vi
set -wg monitor-activity on
# set -wg xterm-keys on

set -sa terminal-overrides ",*:RGB"
