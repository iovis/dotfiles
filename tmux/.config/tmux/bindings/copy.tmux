# Unbind so they use the "root" binding
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
bind -T copy-mode-vi [ send -X previous-prompt -o
bind -T copy-mode-vi ] send -X next-prompt -o

# Selection
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi i send -X select-word

# Search
bind -T copy-mode-vi / command-prompt -i -I "#{pane_search_string}" -T search -p "(search up)" { send-keys -X search-backward-incremental "%%" }
bind -T copy-mode-vi ? command-prompt -i -I "#{pane_search_string}" -T search -p "(search down)" { send-keys -X search-forward-incremental "%%" }

# Copy
bind -T copy-mode-vi y send -X copy-selection-and-cancel
bind -T copy-mode-vi Space send -X copy-pipe-and-cancel "tmux paste-buffer -p"
bind -T copy-mode-vi m-y send -X copy-pipe-no-clear
bind -T copy-mode-vi Y send -X copy-pipe-end-of-line-and-cancel

bind -N "Copy word and paste it directly" -T copy-mode-vi Enter {
  send -X select-word
  send -X copy-pipe-and-cancel "tmux paste-buffer -p"
}

bind -N "Copy line" -T copy-mode-vi c {
  send -X select-line
  send -X copy-pipe-and-cancel
}
