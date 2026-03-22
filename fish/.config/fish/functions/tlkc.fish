function tlkc --wraps='tmux list-keys -T copy-mode-vi'
    tmux list-keys -T copy-mode-vi $argv
end
