function tl --wraps='tmux list-sessions' --description 'alias tl=tmux list-sessions'
    tmux list-sessions $argv
end
