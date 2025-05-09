## Session picker
bind -N "Select or create session from FZF" -n C-f {
  display-popup -w 80% -h 80% -b rounded -E ts
}

bind -N "Switch to last session" -n M-Space {
  switch-client -l
}

## Window switching
bind -n M-H previous-window
bind -n M-L next-window
bind -n M-K last-window
bind -n M-/ last-window

## Switch panes
bind -n C-h  if "$is_vim" "send C-h"  "select-pane -L"
bind -n C-j  if "$is_vim" "send C-j"  "select-pane -D"
bind -n C-k  if "$is_vim" "send C-k"  "select-pane -U"
bind -n C-l  if "$is_vim" "send C-l"  "select-pane -R"

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

## Scratch Session popup
# bind -N "Scratch session popup" -n M-- if -F '#{==:#{session_name},·}' {
#   detach-client
# } {
#   display-popup -w 75% -h 75% -b rounded -d '#{pane_current_path}' -E "tmux new-session -A -s ·"
# }

## Quick Notes
bind -N "Notes session popup" -n M-u {
  display-popup -w 75% -h 75% -b rounded -T " notes " -E notes
}

# bind -n M-n if -F '#{==:#{session_name},notes}' {
#   switch-client -l
# } {
#   new-session -A -s notes -c "$NOTES"
# }
