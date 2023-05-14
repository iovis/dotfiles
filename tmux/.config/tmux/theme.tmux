## Title bar
set -g set-titles on
set -g set-titles-string '#S :: #W'

## Border
set -g pane-border-style 'fg=#414559'
set -g pane-active-border-style '#{?pane_in_mode,fg=#e5c890,#{?synchronize-panes,fg=#ea999c,fg=#8caaee}}'

## Message
set -g message-style 'bg=default,fg=#e5c890'

## Status line
set -g status-interval 5
set -g status-justify left
set -g status-position bottom
set -g status-style 'bg=default,fg=white'

### Left
set -g status-left-length 90

set -g status-left ' #[fg=#8caaee]#S'
set -ag status-left ' '

### Right
set -g status-right-length 60

# NOTE: Tmux format (FORMAT in man page)
#   #{?condition,positive,negative} => show positive if condition, else negative
#   #{!=:left_hand_side,right_hand_side} => compare left to right

# Prefix indicator
set -g status-right '#{?#{!=:#{client_key_table},root},#[fg=#85c1dc]<#{client_key_table}>,}'

# Synchronized panes indicator
set -ag status-right ' #{?pane_synchronized,#[fg=#e78284]sync,}'

# CPU
set -ag status-right ' #{cpu_fg_color}#{cpu_percentage}#{cpu_icon}'

# SSH session
set -ag status-right ' #{?#{SSH_CLIENT},#[fg=colour8]#(whoami)@#h,}'

## Window
set -g base-index 1
set -g pane-base-index 1
set -g renumber-windows on

set -wg automatic-rename on
set -wg automatic-rename-format '#{b:pane_current_path}/#{pane_current_command}'

set -g window-status-activity-style 'bg=default'
set -g window-status-current-format "#[fg=colour8]:: #[fg=#a6d189]#I|#W#{?window_zoomed_flag,#[fg=#85c1dc][+],}"
set -g window-status-format "#[fg=colour8]:: #I|#W#{?window_zoomed_flag,[+],}"

## Pane
# Inactive pane shaded out
# set -wg window-style fg=colour240,bg=default
# set -wg window-active-style fg=white,bg=default

## Copy mode
set -wg mode-style 'bg=#292c3c,fg=white'

set -wg copy-mode-current-match-style 'bg=#8caaee,fg=black'
set -wg copy-mode-mark-style 'bg=default,fg=#a6d189'
set -wg copy-mode-match-style 'bg=#292c3c,fg=white'
