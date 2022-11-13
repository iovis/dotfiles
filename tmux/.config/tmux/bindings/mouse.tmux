bind -T copy-mode-vi WheelDownPane send -N5 -X scroll-down
bind -T copy-mode-vi WheelUpPane   send -N5 -X scroll-up

bind -n WheelUpPane if -F -t = "#{mouse_any_flag}" "send -M" "if -Ft= '#{pane_in_mode}' 'send -M' 'select-pane -t=; copy-mode -e; send -M'"
bind -n WheelDownPane select-pane -t= \; send -M
