## Session picker
bind -N "Create session from FZF" -n C-f {
  choose-tree -Zs
}

bind -N "Switch to last session" -n M-Space {
  switch-client -l
}

## Window switching
bind -n C-\\ last-window  # c-ç
bind -n M--  last-window
bind -n M-h  previous-window
bind -n M-l  next-window

## Window indexing
bind -n M-1 select-window -t :=1
bind -n M-2 select-window -t :=2
bind -n M-3 select-window -t :=3
bind -n M-4 select-window -t :=4
bind -n M-5 select-window -t :=5
bind -n M-6 select-window -t :=6
bind -n M-7 select-window -t :=7
bind -n M-8 select-window -t :=8
bind -n M-9 select-window -t :=9

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
# bind -N "Notes session popup" -n M-n if -F '#{==:#{session_name},notes}' {
#   detach-client
# } {
#   display-popup -w 75% -h 75% -b rounded -d '$NOTES' -E "tmux new-session -A -s notes -c \"$NOTES\""
# }

# bind -n M-n if -F '#{==:#{session_name},notes}' {
#   switch-client -l
# } {
#   new-session -A -s notes -c "$NOTES"
# }
