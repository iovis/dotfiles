# Smart pane switching with awareness of vim splits
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?|fzf|lazygit)(diff)?$'"

##########
# Prefix #
##########
unbind C-b
set -g prefix C-Space
bind Space send-prefix

# Quick find
bind C-f {
  new-window
  send 'f && clear' Enter
}

# Quick settings
bind b {
  attach -c "#{pane_current_path}"
  display "changed path to #{pane_current_path}"
}

bind s set -w synchronize-panes
bind w set -w automatic-rename

# Help & settings
bind ? list-keys
bind L customize-mode -Z

# Window management
bind c new-window -c "#{pane_current_path}"

bind -r < swap-window -dt -1
bind -r > swap-window -dt +1

bind Q confirm -p "kill the rest of the windows? (y/n)" { kill-window -a }
bind º confirm -p "kill-window #W? (y/n)" { kill-window }
bind q confirm -p "reset session? (y/n)" {
  new-window -c "#{pane_current_path}"
  kill-window -a
}

# Split panes
bind H split-window -fv -c "#{pane_current_path}"
bind V split-window -fh -c "#{pane_current_path}"
bind h split-window -v  -c "#{pane_current_path}"
bind v split-window -h  -c "#{pane_current_path}"

# Move panes
bind -r down  swap-pane -dt "{down-of}"
bind -r left  swap-pane -dt "{left-of}"
bind -r right swap-pane -dt "{right-of}"
bind -r up    swap-pane -dt "{up-of}"

# Resize panes equally
bind = select-layout tiled

# Pass-through
bind C-l send 'C-l'
bind C-k send 'C-k'

# Buffers (clipboard)
bind C-p choose-buffer
bind p   paste-buffer

#############
# No Prefix #
#############
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

###############
#  Copy-mode  #
###############
unbind -T copy-mode-vi Enter
unbind -T copy-mode-vi Space

# Enter copy mode
bind -n C-_ if "$is_vim" {
  send C-_
} {
  copy-mode
}

bind ñ if "$is_vim" {
  send ñ
} {
  copy-mode
  send ñ
}

# Movement
bind -T copy-mode-vi H send -X back-to-indentation
bind -T copy-mode-vi L send -X end-of-line
bind -T copy-mode-vi K send -X top-line
bind -T copy-mode-vi J send -X bottom-line
bind -T copy-mode-vi d send -X halfpage-down
bind -T copy-mode-vi u send -X halfpage-up

# Search
bind -T copy-mode-vi ñ command-prompt -p "(search up)"   { send -X search-backward "%%%" }
bind -T copy-mode-vi Ñ command-prompt -p "(search down)" { send -X search-forward  "%%%" }

# Marks
bind -T copy-mode-vi m   send -X set-mark
bind -T copy-mode-vi "'" send -X jump-to-mark

# Quick select
bind -T copy-mode-vi a send -X copy-pipe
bind -T copy-mode-vi s send -X select-word
bind -T copy-mode-vi v send -X begin-selection

bind -T copy-mode-vi c send Escape 'V!'
bind -T copy-mode-vi C send Escape 'v$!'

bind -T copy-mode-vi p {
  send -X select-word
  send -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
}

bind -T copy-mode-vi P {
  send -X select-word
  send -X copy-pipe-and-cancel "tmux paste-buffer"
}

# Switch panes
bind -T copy-mode-vi C-h  select-pane -L
bind -T copy-mode-vi C-j  select-pane -D
bind -T copy-mode-vi C-k  select-pane -U
bind -T copy-mode-vi C-l  select-pane -R
bind -T copy-mode-vi C-\\ select-pane -l # c-ç

# Resize panes
bind -T copy-mode-vi C-down  resize-pane -D 5
bind -T copy-mode-vi C-left  resize-pane -L 5
bind -T copy-mode-vi C-right resize-pane -R 5
bind -T copy-mode-vi C-up    resize-pane -U 5

###########
#  Mouse  #
###########
bind -T copy-mode-vi WheelDownPane send -N5 -X scroll-down
bind -T copy-mode-vi WheelUpPane   send -N5 -X scroll-up

bind -n WheelUpPane if -F -t = "#{mouse_any_flag}" "send -M" "if -Ft= '#{pane_in_mode}' 'send -M' 'select-pane -t=; copy-mode -e; send -M'"
bind -n WheelDownPane select-pane -t= \; send -M
