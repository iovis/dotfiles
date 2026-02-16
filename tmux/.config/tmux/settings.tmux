set -g base-index 1
set -g detach-on-destroy off
set -g display-panes-time 4000
set -g display-time 100000
set -g focus-events on
set -g history-limit 100000
set -g mouse on
set -g pane-base-index 1
set -g remain-on-exit off # failed
set -g renumber-windows on
set -g set-clipboard on
set -g status-keys emacs
set -g visual-activity off

set -wg automatic-rename on
set -wg automatic-rename-format '#{pane_current_command}'
set -wg mode-keys vi
set -wg monitor-activity on

set -s extended-keys always
set -s terminal-features "xterm*:clipboard:ccolour:cstyle:extkeys:focus:hyperlinks:overline:RGB:strikethrough:title:usstyle"
set -sg default-terminal "tmux-256color"
set -sg escape-time 0

# Make Yazi render images properly
set -g allow-passthrough on
set -ga update-environment TERM
set -ga update-environment TERM_PROGRAM
