function tlkp --wraps='tmux list-keys -T prefix'
    tmux list-keys -T prefix $argv
end
