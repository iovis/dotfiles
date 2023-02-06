function tm --wraps='tmux attach || tmux new-session' --description 'alias tm=tmux attach || tmux new-session'
    tmux attach || tmux new-session $argv
end
