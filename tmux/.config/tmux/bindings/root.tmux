## Window switching
bind -n M-Space switch-client -l
bind -n C-M-Space last-window
bind -n C-M-h previous-window
bind -n C-M-l next-window
bind -n C-M-j swap-window -d -t -1
bind -n C-M-k swap-window -d -t +1

## Switch panes
bind -n M-i last-pane
bind -n C-h if "$forward_keys" "send C-h" "select-pane -L"
bind -n C-j if "$forward_keys" "send C-j" "select-pane -D"
bind -n C-k if "$forward_keys" "send C-k" "select-pane -U"
bind -n C-l if "$forward_keys" "send C-l" "select-pane -R"

## Floating panes
bind -N "Toggle floating pane" -n M-/ if -F "#{pane_floating_flag}" {
  join-pane
} {
  break-pane -W -x 50% -y 50%
  move-pane -P centre
}

bind -N "Reset floating pane dimensions and center" -n C-M-, if -F "#{pane_floating_flag}" {
  resize-pane -x 50% -y 50%
  move-pane -P centre
} {
  break-pane -W -x 50% -y 50%
  move-pane -P centre
}

## Resize panes
bind -n M-m     resize-pane -Z

bind -n C-down  resize-pane -D 5
bind -n C-right resize-pane -R 20
bind -n C-up    if -F "#{pane_floating_flag}" "resize-pane -D -5"  "resize-pane -U 5"
bind -n C-left  if -F "#{pane_floating_flag}" "resize-pane -R -20" "resize-pane -L 20"

bind -n C-M-down  if "$forward_keys" "send C-M-down"  "resize-pane -D 1"
bind -n C-M-right if "$forward_keys" "send C-M-right" "resize-pane -R 1"
bind -n C-M-up if "$forward_keys" {
  send C-M-up
} {
  if -F "#{pane_floating_flag}" {
    resize-pane -D -1
  } {
    resize-pane -U 1
  }
}
bind -n C-M-left if "$forward_keys" {
  send C-M-left
} {
  if -F "#{pane_floating_flag}" {
    resize-pane -R -1
  } {
    resize-pane -L 1
  }
}
