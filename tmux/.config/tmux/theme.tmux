## Border
set -g pane-border-style 'fg=#414559'
set -g pane-active-border-style '#{?pane_in_mode,fg=#e5c890,#{?synchronize-panes,fg=#ea999c,fg=#8caaee}}'

set -g popup-border-style 'fg=#414559'
set -g popup-border-lines rounded

## Message
set -g message-style 'bg=default,fg=#8caaee'

## Status line
set -g status-style 'bg=default,fg=#51576d'

### Left
set -g status-left-length 90

set -g  status-left ''
set -ag status-left '#[bg=default,fg=#232634] '
set -ag status-left '#[bg=#232634,fg=#8caaee] #S'
set -ag status-left '#[bg=default,fg=#232634] '

### Right
set -g status-right-length 60
set -g status-right ''

# NOTE: Tmux format (FORMAT in man page)
#   #{?condition,positive,negative} => show positive if condition, else negative
#   #{!=:left_hand_side,right_hand_side} => compare left to right

# Prefix indicator
set -ag status-right '#[fg=#51576d]#{?#{!=:#{client_key_table},root},<#{client_key_table}>,}'

# Synchronized panes indicator
set -ag status-right '#[fg=#e78284]#{?pane_synchronized, sync,}'

# CPU
set -ag status-right ' #{cpu_fg_color}#{cpu_percentage}#{cpu_icon}'

# SSH session
set -ag status-right '#[fg=#51576d]#{?#{SSH_CLIENT}, #(whoami)@#h,} '

## Window
set -g window-status-activity-style 'bg=default'

set -g window-status-current-format '#[fg=#{?window_zoomed_flag,#dabeed,#a6d189}]#W'
set -g window-status-format '#[fg=#51576d]#W'

## Pane
# Inactive pane shaded out
# set -wg window-style fg=colour240,bg=default
# set -wg window-active-style fg=white,bg=default

## Copy mode
set -wg mode-style 'bg=#292c3c,fg=white'

set -wg copy-mode-current-match-style 'bg=#8caaee,fg=black'
set -wg copy-mode-mark-style 'bg=default,fg=#a6d189'
set -wg copy-mode-match-style 'bg=#414559,fg=white'
