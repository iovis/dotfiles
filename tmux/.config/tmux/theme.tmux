set -g status-interval 5
set -g status-position bottom

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
set -ag status-left '#[bg=default,fg=#232634]'
set -ag status-left '#[bg=#232634,fg=#8caaee]  #S '
set -ag status-left '#[bg=default,fg=#232634]'
set -ag status-left '#[bg=default,fg=#a6d189,bold] #{?window_zoomed_flag,[+],}'

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
set -g status-justify absolute-centre # Center window list
set -g window-status-separator ' '
set -g window-status-activity-style ''
set -g window-status-bell-style ''

set -g window-status-current-format ''
set -ag window-status-current-format '#[bg=default,fg=#414559]#[bg=#414559,fg=#a6d189,bold]#I#[bg=#303446,fg=#414559]' # Number
set -ag window-status-current-format '#[bg=#303446,fg=#8caaee,bold] #W' # Window name
set -ag window-status-current-format '#[bg=default,fg=#303446]'

set -g window-status-format ''
set -ag window-status-format '#[bg=default,fg=#{?window_bell_flag,#e78285,#303446}]#[bg=#{?window_bell_flag,#e78285,#303446},fg=#{?window_bell_flag,#232634,#737994},bold]#I#[bg=#232634,fg=#{?window_bell_flag,#e78285,#303446}]' # Number
set -ag window-status-format '#[bg=#232634,fg=#{?window_bell_flag,#e78285,#838ba7},nobold] #W' # Window name
set -ag window-status-format '#[bg=default,fg=#232634]'

## Pane
# Inactive pane shaded out
# set -wg window-style fg=colour240,bg=default
# set -wg window-active-style fg=white,bg=default

## Copy mode
set -wg mode-style 'bg=#292c3c,fg=white'

set -wg copy-mode-current-match-style 'bg=#8caaee,fg=black'
set -wg copy-mode-mark-style 'bg=default,fg=#a6d189'
set -wg copy-mode-match-style 'bg=#414559,fg=white'

# Minimalistic Status
# set -g status-justify left
# set -g status-style bg=default,fg=black,bright
# set -g status-left ""
# set -g status-right "#[fg=black,bright]#S"
#
# set -g window-status-format ""
# set -g window-status-current-format ""
# set -g window-status-current-style "#{?window_zoomed_flag,fg=green,fg=magenta,nobold}"
# set -g window-status-activity-style "fg=red,nobold"
