## Title bar
set -g set-titles on
set -g set-titles-string '#S :: #W'

## Message
set -g message-style 'bg=default,fg=yellow'

## Status line
set -g status-interval 5
set -g status-justify left
set -g status-style 'bg=default,fg=white'

### Left
set -g status-left-length 90

set -g status-left ' '
set -ag status-left '#[fg=blue]#S'
set -ag status-left ' '

### Right
set -g status-right-length 60

# Prefix indicator
# NOTE: Tmux format (FORMAT in man page)
# #{?condition,positive,negative} => show positive if condition, else negative
# #{!=:left_hand_side,right_hand_side} => compare left to right
set -g status-right '#{?#{!=:#{client_key_table},root},#[fg=cyan]<#{client_key_table}>,}'

# Synchronized panes indicator
set -ag status-right ' '
set -ag status-right '#{?pane_synchronized,#[fg=blue]sync,}'

# CPU
set -ag status-right ' '
set -ag status-right '#{cpu_fg_color}#{cpu_percentage}#{cpu_icon}'
set -ag status-right ' '

## Window
set -g base-index 1
set -g pane-base-index 1
set -g renumber-windows on

set -wg automatic-rename on
set -wg automatic-rename-format '#{b:pane_current_path}/#{pane_current_command}'

set -g window-status-activity-style 'bg=default'
set -g window-status-current-format "#[fg=white]:: #[fg=green]#I|#W#{?window_zoomed_flag,#[fg=blue][+],}"
set -g window-status-format ":: #{?window_activity_flag,#[fg=red],}#I|#W"

## Pane
# Inactive pane shaded out
# set -wg window-style fg=colour240,bg=default
# set -wg window-active-style fg=white,bg=default

## Copy mode
set -wg mode-style 'bg=#383838,fg=white'

set -wg copy-mode-current-match-style 'bg=blue,fg=black'
set -wg copy-mode-mark-style 'bg=default,fg=green'
set -wg copy-mode-match-style 'bg=#383838,fg=white'
