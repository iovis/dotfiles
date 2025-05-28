function capture_pane --wraps='tmux capture-pane -Jp -S-'
    tmux capture-pane -Jp -S- $argv
end
