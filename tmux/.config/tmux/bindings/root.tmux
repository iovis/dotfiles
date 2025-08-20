## Session picker
bind -N "Select or create session from FZF" -n C-f {
  display-popup -w 80% -h 80% -b none -E ts
}

bind -N "Switch to last session" -n M-Space {
  switch-client -l
}

## Window switching
bind -n C-M-Space last-window
bind -n C-M-h previous-window
bind -n C-M-l next-window
bind -n C-M-j swap-window -dt -1
bind -n C-M-k swap-window -dt +1

## Switch panes
bind -n C-h if "$is_vim" "send C-h"  "select-pane -L"
bind -n C-j if "$is_vim" "send C-j"  "select-pane -D"
bind -n C-k if "$is_vim" "send C-k"  "select-pane -U"
bind -n C-l if "$is_vim" "send C-l"  "select-pane -R"

##
# In hindsight, this was a terrible idea, but it was hard enough to
# find out how to make this even work, so here it is, as a wall of shame
#
# bind -n C-h if "$is_vim" {
#   # TODO: make neovim understand this
#   send C-h
# } {
#   if -F "#{pane_at_left}" {
#     previous-window
#   } {
#     select-pane -L
#   }
# }
#
# bind -n C-l if "$is_vim" {
#   # TODO: make neovim understand this
#   send C-l
# } {
#   if -F "#{pane_at_right}" {
#     next-window
#   } {
#     select-pane -R
#   }
# }

## Resize panes
bind -n C-down  resize-pane -D 5
bind -n C-left  resize-pane -L 20
bind -n C-right resize-pane -R 20
bind -n C-up    resize-pane -U 5
bind -n M-m     resize-pane -Z

## Quick Notes popup
bind -N "Notes popup" -n M-u if -F '#{==:#{session_name},notes}' {
  detach-client
} {
  display-popup -w 75% -h 75% -b rounded -T " notes " -E "tmux new-session -A -s notes notes"
}
