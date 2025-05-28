function tl --wraps='tmux list-sessions'
    tmux list-sessions $argv
end
