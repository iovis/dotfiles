unbind C-b
set -g prefix C-Space
bind Space send-prefix

# Pass-through
bind C-l send 'C-l'
bind C-k send 'C-k'

## Quick settings
# Reload tmux
bind R {
  source "$XDG_CONFIG_HOME/tmux/tmux.conf"
  display "Tmux reloaded!"
}

# Toggle status line
bind s {
  set status
}

# Set session path to current
bind b {
  attach -c "#{pane_current_path}"
  display "changed path to #{pane_current_path}"
}

bind S set -w synchronize-panes
bind w set -w automatic-rename
bind ? list-keys

## Paste Buffers (clipboard)
bind C-p choose-buffer
bind p   paste-buffer

## Session management
bind c-f run sessionist

bind C command-prompt -p "new session name:" {
  new-session -A -s "%1" -c "#{pane_current_path}"
}

bind X confirm-before -p "Kill session #{session_name}? (y/n)" {
  switch-client -l
  run 'tmux kill-session -t #{client_last_session}'
}

# TODO: Promote pane to session
# bind '"'
# https://github.com/tmux-plugins/tmux-sessionist/blob/master/scripts/promote_pane.sh

## Window management
bind c new-window -c "#{pane_current_path}"

bind -r < swap-window -dt -1
bind -r > swap-window -dt +1

bind Q confirm -p "kill the rest of the windows? (y/n)" { kill-window -a }
bind º confirm -p "kill-window #W? (y/n)" { kill-window }
bind q confirm -p "reset session? (y/n)" {
  new-window -c "#{pane_current_path}"
  kill-window -a
}

## Pane Management
bind h split-window -v  -c "#{pane_current_path}"
bind v split-window -h  -c "#{pane_current_path}"

# Resize panes equally
bind 0 select-layout tiled

# Move panes
bind -r down  swap-pane -dt "{down-of}"
bind -r left  swap-pane -dt "{left-of}"
bind -r right swap-pane -dt "{right-of}"
bind -r up    swap-pane -dt "{up-of}"

# Make pane full split
bind H move-pane -fh -b -t '.{next}'
bind J move-pane -fv -t '.{next}'
bind K move-pane -fv -b -t '.{next}'
bind L move-pane -fh -t '.{next}'

## Join panes
bind t switch-client -T join_pane

bind -T join_pane h {
  join-pane -v
}

bind -T join_pane v {
  join-pane -h
}
