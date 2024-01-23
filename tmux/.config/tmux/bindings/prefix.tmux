unbind C-b
set -g prefix C-Space
unbind Space
unbind z  # Unbind zoom

# Pass-through
bind C-l send 'C-l'
bind C-k send 'C-k'

## Quick settings
bind -N "Reload tmux" R {
  source "$XDG_CONFIG_HOME/tmux/tmux.conf"
  display "Tmux reloaded!"
}

bind -N "Toggle status line" z {
  set status
}

bind -N "Set session path to current pane's" b {
  attach -c "#{pane_current_path}"
  display "changed path to #{pane_current_path}"
}

bind -N "Set session name and path to current pane's" i {
  attach -c "#{pane_current_path}"
  display "changed path to #{pane_current_path}"
  run tmux_set_session_name
}

bind -N "Toggle synchronize panes" S {
  set -w synchronize-panes
}

bind -N "Toggle automatic window rename" w {
  set -w automatic-rename
}

bind -N "List keys" ? list-keys

## Paste Buffers (clipboard)
bind -N "Choose paste buffer" C-p choose-buffer
bind -N "Paste buffer" P paste-buffer

## Session management
bind -N "Run sessionist" c-f run sessionist

bind -N "New session" C command-prompt -p "new session name:" {
  new-session -A -s "%1" -c "#{pane_current_path}"
}

bind -N "Kill session" X {
  switch-client -l
  run 'tmux kill-session -t #{client_last_session}'
}

## Window management
bind -N "New window" c new-window -c "#{pane_current_path}"

bind -N "Move window to the left"  -r < swap-window -dt -1
bind -N "Move window to the right" -r > swap-window -dt +1

bind -N "Close the rest of the windwos" Q confirm -p "kill the rest of the windows? (y/n)" {
  kill-window -a
}

bind -N "Kill window" º confirm -p "kill-window #W? (y/n)" {
  kill-window
}

bind -N "Reset session" q confirm -p "reset session? (y/n)" {
  new-window -c
  kill-window -a
}

## Pane Management
bind-key -N "Kill pane" x kill-pane

bind -N "Horizontal pane" h {
  split-window -v -c "#{pane_current_path}"
}

bind -N "Horizontal pane (full)" s {
  split-window -fv -c "#{pane_current_path}"
}

bind -N "Vertical pane" v {
  split-window -h -c "#{pane_current_path}"
}

bind -N "Vertical pane (full)" V {
  split-window -fh -c "#{pane_current_path}"
}

bind -N "Resize panes equally" 0 {
  select-layout tiled
}

# Move panes
bind -N "Move pane down"  -r down  swap-pane -dt "{down-of}"
bind -N "Move pane left"  -r left  swap-pane -dt "{left-of}"
bind -N "Move pane right" -r right swap-pane -dt "{right-of}"
bind -N "Move pane up"    -r up    swap-pane -dt "{up-of}"

# Make pane full split
bind -N "Move pane down (full)"  H move-pane -fh -b -t '.{next}'
bind -N "Move pane left (full)"  J move-pane -fv -t '.{next}'
bind -N "Move pane right (full)" K move-pane -fv -b -t '.{next}'
bind -N "Move pane up (full)"    L move-pane -fh -t '.{next}'

bind -N "Promote pane to session" '"' {
  run tmux_promote_pane
}

## Join panes
bind -N "Join pane" j switch-client -T join_pane

bind -N "Join pane horizontally" -T join_pane h {
  join-pane -v
}

bind -N "Join pane vertically" -T join_pane v {
  join-pane -h
}
