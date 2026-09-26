# Scrolling
bind -n WheelUpPane if -F -t = "#{mouse_any_flag}" "send -M" "if -Ft= '#{pane_in_mode}' 'send -M' 'select-pane -t=; copy-mode -e; send -N5 -X scroll-up'"
bind -n WheelDownPane "select-pane -t= \; send -M"
bind -T copy-mode-vi WheelDownPane send -N5 -X scroll-down
bind -T copy-mode-vi WheelUpPane   send -N5 -X scroll-up

bind -n S-WheelUpPane if -F -t = "#{mouse_any_flag}" "send -M" "if -Ft= '#{pane_in_mode}' 'send -M' 'select-pane -t=; copy-mode -e; send -N25 -X scroll-up'"
bind -n S-WheelDownPane "select-pane -t= \; send -M"
bind -T copy-mode-vi S-WheelDownPane send -N25 -X scroll-down
bind -T copy-mode-vi S-WheelUpPane   send -N25 -X scroll-up

bind -n M-WheelUpPane if -F -t = "#{mouse_any_flag}" "send -M" "if -Ft= '#{pane_in_mode}' 'send -M' 'select-pane -t=; copy-mode -e; send -X scroll-up'"
bind -n M-WheelDownPane "select-pane -t= \; send -M"
bind -T copy-mode-vi M-WheelDownPane send -X scroll-down
bind -T copy-mode-vi M-WheelUpPane   send -X scroll-up

# Right click focuses the pane; right drag selects text unless the pane handles mouse input
bind -n MouseDown3Pane "select-pane -t= \; send -M"
bind -n MouseDrag3Pane if -F '#{||:#{pane_in_mode},#{mouse_any_flag}}' "send -M" "copy-mode -M"
