unbind C-b
set -g prefix C-Space
bind Space send-prefix

# Reload tmux
bind R {
  source "$XDG_CONFIG_HOME/tmux/tmux.conf"
  display "Tmux reloaded!"
}

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
