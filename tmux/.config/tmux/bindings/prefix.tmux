unbind C-b
set -g prefix C-Space
unbind Space

# Pass-through
bind C-l send 'C-l'

## Quick settings
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

bind -N "Toggle synchronize panes" C-s {
  set -w synchronize-panes
}

bind -N "Toggle automatic window rename" w {
  set -w automatic-rename
}

bind -N "Toggle monitor activity" a {
  set -wg monitor-activity
  display 'monitor-activity #{?monitor-activity,on,off}'
}

bind -N "Command prompt" c-\; command-prompt
bind -N "Command prompt" \; command-prompt

bind -N "List keys" ? {
  new-pane -E -x 75% -y 75% -T "tmux keybindings"
  set -p pane-border-status top
  set -p pane-border-format ' #{pane_title} '
  move-pane -P centre
  respawn-pane "tmux list-keys | nvim +'se ft=tmux' +ZenModeWide"
}

## Session management
bind -N "Detach session" C-d detach-client
bind -N "Kill session" X run tmux_kill_session

bind -N "muxi picker" C-_ {
  run "muxi fzf"
}

bind -N "muxi picker" C-/ {
  run "muxi fzf"
}

bind -N "Run FZF session picker" C-f {
  new-pane -OKC -B none -x 80% -y 80% tmux_sessions
  move-pane -P centre
}

bind -N "Run sessionist" C-k {
  new-pane -OKC -B none -x 50% -y 60% sessionist
  move-pane -P centre
}

bind -N "Run zoxide_sessionist" C-o {
  new-pane -OKC -B none -x 50% -y 60% zoxide_sessionist
  move-pane -P centre
}

bind -N "Rename session" .   command-prompt -I "#S" { rename-session "%%" }
bind -N "Rename session" C-. command-prompt -I "#S" { rename-session "%%" }

bind -N "New session" C-n command-prompt -p "new session name:" {
  new-session -A -s "%1" -c "#{pane_current_path}"
}

bind -N "Promote pane to session" s {
  run tmux_promote_pane
}

bind -N "Reset session" Q {
  new-window
  kill-window -a
}

## Window management
bind -N "New window" C-c new-window
bind -N "New window (current path)" C-t {
  new-window -c "#{pane_current_path}"
}

bind -N "Rename window" , command-prompt -I "#W" { rename-window "%%" }

bind -N "Rename window or center floating pane" C-, if -F "#{pane_floating_flag}" {
  move-pane -P centre
} {
  command-prompt -I "#W" { rename-window "%%" }
}

bind -N "Close window" C-w kill-window
bind -N "Reset window" q {
  kill-pane -a
  respawn-pane -k -c "#{pane_current_path}" "$SHELL"
}

bind -N "Close the rest of the windows" o {
  kill-window -a
}

bind -N "Open lazygit" C-j {
  new-window -S -c "#{pane_current_path}" -n lazygit lazygit
}

bind -N "Open yazi" C-y {
  new-window -S -c "#{pane_current_path}" -n yazi yazi
}

bind -N "Open Vim plugin" C-p {
  new-pane -O -K -B none -x 50% -y 60% -c "#{pane_current_path}" vim_plugins
  move-pane -P centre
}

## Pane Management
bind -N "Kill pane" C-x kill-pane

bind -N "New floating pane" C-b {
  new-pane -x 50% -y 50% -c "#{pane_current_path}"
  move-pane -P centre
}

bind -N "Horizontal pane" C-h {
  split-window -v -c "#{pane_current_path}"
}

bind -N "Vertical pane" C-v {
  split-window -h -c "#{pane_current_path}"
}

bind -N "Resize panes equally" = {
  select-layout tiled
}

bind -N "Resize panes equally" C-= {
  select-layout tiled
}

# Move panes
bind -N "Move pane down" -r c-down if -F "#{pane_floating_flag}" {
  move-pane -P bottom-centre
} {
  swap-pane -d -t "{down-of}"
}

bind -N "Move pane left" -r c-left if -F "#{pane_floating_flag}" {
  move-pane -P centre-left
} {
  swap-pane -d -t "{left-of}"
}

bind -N "Move pane right" -r c-right if -F "#{pane_floating_flag}" {
  move-pane -P centre-right
} {
  swap-pane -d -t "{right-of}"
}

bind -N "Move pane up" -r c-up if -F "#{pane_floating_flag}" {
  move-pane -P top-centre
} {
  swap-pane -d -t "{up-of}"
}

## Switch panes (fallback)
bind down  select-pane -D
bind left  select-pane -L
bind right select-pane -R
bind up    select-pane -U

# Make pane full split
bind -N "Move pane left (full)" H if -F "#{pane_floating_flag}" {
  resize-pane -x 50% -y 100%
  move-pane -P centre-left
} {
  move-pane -fh -b -t '.{next}'
}

bind -N "Move pane down (full)" J if -F "#{pane_floating_flag}" {
  resize-pane -x 100% -y 50%
  move-pane -P bottom-centre
} {
  move-pane -fv -t '.{next}'
}

bind -N "Move pane up (full)" K if -F "#{pane_floating_flag}" {
  resize-pane -x 100% -y 50%
  move-pane -P top-centre
} {
  move-pane -fv -b -t '.{next}'
}

bind -N "Move pane right (full)" L if -F "#{pane_floating_flag}" {
  resize-pane -x 50% -y 100%
  move-pane -P centre-right
} {
  move-pane -fh -t '.{next}'
}

bind -N "Break pane" Tab break-pane
bind -N "Break pane detached" Enter break-pane -d

## Join panes
bind -N "Join pane" j {
  switch-client -T join_pane
  display -d 30000 " Join Pane: [j]-Last [h]-Horizontally [v]-Vertically"
}

bind -N "Join last pane" -T join_pane j {
  join-pane -s '{last}.'
}

bind -N "Join pane horizontally" -T join_pane h {
  join-pane -v
}

bind -N "Join pane vertically" -T join_pane v {
  join-pane -h
}
