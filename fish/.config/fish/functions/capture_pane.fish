function capture_pane --wraps='tmux capture-pane -Jp -S-' --description 'alias capture_pane tmux capture-pane -Jp -S-'
    tmux capture-pane -Jp -S- $argv
end
