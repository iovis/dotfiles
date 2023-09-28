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
bind -T copy-mode-vi p send -X search-reverse

# Search
bind -T copy-mode-vi ñ command-prompt -i -I "#{pane_search_string}" -T search -p "(search up)" { send-keys -X search-backward-incremental "%%" }
bind -T copy-mode-vi Ñ command-prompt -i -I "#{pane_search_string}" -T search -p "(search down)" { send-keys -X search-forward-incremental "%%" }

# Marks
bind -T copy-mode-vi m   send -X set-mark
bind -T copy-mode-vi "'" send -X jump-to-mark

# Quick select
bind -N "append selection" -T copy-mode-vi a send -X copy-pipe-no-clear "pbcopy"
bind -T copy-mode-vi v send -X begin-selection

bind -N "Copy selection and paste it directly" -T copy-mode-vi Enter {
  send -X copy-pipe-and-cancel "tmux paste-buffer"
}

bind -N "Copy line" -T copy-mode-vi C send Escape 'V!'
bind -N "Copy word" -T copy-mode-vi c {
  send -X select-word
  send -X copy-pipe-and-cancel "pbcopy"
}

bind -N "Copy till end of line" -T copy-mode-vi Y {
  send Escape 'v$!'
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
