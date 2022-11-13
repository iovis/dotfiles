# Session picker
bind -n C-f choose-tree -Zs

# Window switching
bind -n M-l     last-window
bind -n S-left  previous-window
bind -n S-right next-window

# Window indexing
bind -n M-1 select-window -t :=1
bind -n M-2 select-window -t :=2
bind -n M-3 select-window -t :=3
bind -n M-4 select-window -t :=4
bind -n M-5 select-window -t :=5
bind -n M-6 select-window -t :=6
bind -n M-7 select-window -t :=7
bind -n M-8 select-window -t :=8
bind -n M-9 select-window -t :=9

# Switch panes
bind -n C-h  if "$is_vim" "send C-h"  "select-pane -L"
bind -n C-j  if "$is_vim" "send C-j"  "select-pane -D"
bind -n C-k  if "$is_vim" "send C-k"  "select-pane -U"
bind -n C-l  if "$is_vim" "send C-l"  "select-pane -R"
bind -n C-\\ if "$is_vim" 'send C-\\' "select-pane -l" # c-ç

# Resize panes
bind -n C-down  resize-pane -D 5
bind -n C-left  resize-pane -L 5
bind -n C-right resize-pane -R 5
bind -n C-up    resize-pane -U 5
