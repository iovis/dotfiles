function tlkr --wraps='tmux list-keys -T root'
    tmux list-keys -T root $argv
end
