unbind C-b
set -g prefix C-Space
unbind Space

bind -N "Command prompt" \; {
  command-prompt
}

# Pass-through
bind -r C-f send 'C-f'
bind C-k send 'C-k'
bind C-l send 'C-l'

## Quick settings
bind -N "Reload tmux" R {
  source "$XDG_CONFIG_HOME/tmux/tmux.conf"
  display "Tmux reloaded!"
}

bind -N "Toggle status line" z set -sg status
bind -N "Toggle status position" T set -sg status-position

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

bind -N "Toggle monitor activity" a {
  set -wg monitor-activity
  display 'monitor-activity #{?monitor-activity,on,off}'
}

bind -N "List keys" ? list-keys

## Session management
bind -N "Detach session" C-d detach-client
bind -N "Kill session" X run tmux_kill_session

bind -N "muxi picker" C-_ {
  run "muxi fzf"
}

bind -N "Run sessionist" C-k {
  display-popup -w 50% -h 60% -b none -E sessionist
}
bind -N "Run zoxide_sessionist" C-o {
  display-popup -w 50% -h 60% -b none -E zoxide_sessionist
}

bind -N "Rename session" . command-prompt -I "#S" {
  rename-session "%%"
}

bind -N "New session" C command-prompt -p "new session name:" {
  new-session -A -s "%1" -c "#{pane_current_path}"
}

bind -N "New session" C-n command-prompt -p "new session name:" {
  new-session -A -s "%1" -c "#{pane_current_path}"
}

bind -N "Reset session" q confirm -p "reset session? (y/n)" {
  new-window -c "#{pane_current_path}"
  kill-window -a
}

## Window management
bind -N "New window" c new-window
bind -N "New window" C-c new-window
bind -N "New window (current path)" Tab new-window -c "#{pane_current_path}"

bind -N "Close the rest of the windows" Q confirm -p "kill the rest of the windows? (y/n)" {
  kill-window -a
}

bind -N "Open lazygit" C-j {
  new-window -S -c "#{pane_current_path}" -n lazygit lazygit
}

bind -N "Open yazi" C-y {
  new-window -S -c "#{pane_current_path}" -n yazi yazi
}

bind -N "Open Vim plugin" C-p {
  display-popup -w 50% -h 60% -b none -E vim_plugins
}

## Pane Management
bind-key -N "Kill pane" C-x kill-pane
bind-key -N "Kill pane" x kill-pane

bind -N "Horizontal pane" h {
  split-window -v -c "#{pane_current_path}"
}

bind -N "Horizontal pane" C-h {
  split-window -v -c "#{pane_current_path}"
}

bind -N "Horizontal pane (full)" s {
  split-window -fv -c "#{pane_current_path}"
}

bind -N "Vertical pane" v {
  split-window -h -c "#{pane_current_path}"
}

bind -N "Vertical pane" C-v {
  split-window -h -c "#{pane_current_path}"
}

bind -N "Vertical pane (full)" V {
  split-window -fh -c "#{pane_current_path}"
}

bind -N "Resize panes equally" 0 {
  select-layout tiled
}

bind -N "Resize panes equally" = {
  select-layout tiled
}

# Move panes
bind -N "Move pane down"  -r down  swap-pane -d -t "{down-of}"
bind -N "Move pane left"  -r left  swap-pane -d -t "{left-of}"
bind -N "Move pane right" -r right swap-pane -d -t "{right-of}"
bind -N "Move pane up"    -r up    swap-pane -d -t "{up-of}"

## Switch panes
bind C-down select-pane -D
bind C-left select-pane -L
bind C-right select-pane -R
bind C-up select-pane -U

# Make pane full split
bind -N "Move pane down (full)"  H move-pane -fh -b -t '.{next}'
bind -N "Move pane left (full)"  J move-pane -fv -t '.{next}'
bind -N "Move pane right (full)" K move-pane -fv -b -t '.{next}'
bind -N "Move pane up (full)"    L move-pane -fh -t '.{next}'

bind -N "Promote pane to session" @ {
  run tmux_promote_pane
}

## Join panes
bind -N "Join pane" j {
  switch-client -T join_pane
  display " Join Pane: [h]-Horizontally [v]-Vertically"
}

bind -N "Join pane horizontally" -T join_pane h {
  join-pane -v
}

bind -N "Join pane vertically" -T join_pane v {
  join-pane -h
}
