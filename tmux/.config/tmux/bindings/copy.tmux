# Unbind so they use the "root" binding
unbind -T copy-mode-vi Enter
unbind -T copy-mode-vi Space
unbind -T copy-mode-vi C-h
unbind -T copy-mode-vi C-j
unbind -T copy-mode-vi C-k
unbind -T copy-mode-vi C-l
unbind -T copy-mode-vi C-down
unbind -T copy-mode-vi C-up

# Enter copy mode
bind -n C-_ if "$forward_keys" {
  send C-_
} {
  copy-mode
}

bind -n C-/ if "$forward_keys" {
  send C-/
} {
  copy-mode
}

# Movement
bind -T copy-mode-vi H send -X back-to-indentation
bind -T copy-mode-vi L send -X end-of-line
bind -T copy-mode-vi K send -X top-line
bind -T copy-mode-vi J send -X bottom-line
bind -T copy-mode-vi d send -X halfpage-down
bind -T copy-mode-vi u send -X halfpage-up
bind -T copy-mode-vi p send -X search-reverse

# Search
bind -T copy-mode-vi / command-prompt -i -I "#{pane_search_string}" -T search -p "(search up)" { send-keys -X search-backward-incremental "%%" }
bind -T copy-mode-vi ? command-prompt -i -I "#{pane_search_string}" -T search -p "(search down)" { send-keys -X search-forward-incremental "%%" }

# Marks
bind -T copy-mode-vi m   send -X set-mark
bind -T copy-mode-vi "'" send -X jump-to-mark

# Quick select
bind -N "append selection" -T copy-mode-vi a send -X copy-pipe-no-clear "pbcopy"
bind -T copy-mode-vi v send -X begin-selection

bind -N "Copy word and paste it directly" -T copy-mode-vi Enter {
  send -X select-word
  send -X copy-pipe-and-cancel "tmux paste-buffer -p"
}

bind -N "Copy WORD and paste it directly" -T copy-mode-vi i {
  send Escape 'lBvE' Space
}

bind -N "Copy word" -T copy-mode-vi c {
  send -X select-word
  send -X copy-pipe-and-cancel "pbcopy"
}

bind -N "Copy line" -T copy-mode-vi C {
  send -X select-line
  send -X copy-pipe-and-cancel "pbcopy"
}

bind -N "Copy till end of line" -T copy-mode-vi Y {
  send Escape 'v$!'
}
