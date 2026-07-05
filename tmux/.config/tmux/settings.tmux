set -g base-index 1
set -g detach-on-destroy off
set -g clock-mode-style 24-with-seconds
set -g copy-mode-line-numbers hybrid
set -g display-panes-time 4000
set -g display-time 100000
set -g focus-events on
set -g focus-follows-mouse off
set -g history-limit 100000
set -g mouse on
set -g pane-base-index 1
set -g remain-on-exit off  # off|on|failed|key
set -g renumber-windows on
set -g set-clipboard on
set -g status-keys emacs
set -g visual-activity off

set -wg automatic-rename on
set -wg automatic-rename-format '#{pane_current_command}'
set -wg mode-keys vi
set -wg monitor-activity on

set -s extended-keys on
set -s extended-keys-format csi-u
set -g default-terminal "tmux-256color"
set -g escape-time 0

# Make Yazi render images properly
set -g allow-passthrough on
set -gu update-environment
set -ag update-environment TERM
set -ag update-environment TERM_PROGRAM

# Terminal features
set -su terminal-features
set -as terminal-features "xterm*:256:extkeys:hyperlinks:overline:margins:mouse:osc7:rectfill:RGB:strikethrough:sync:usstyle"
