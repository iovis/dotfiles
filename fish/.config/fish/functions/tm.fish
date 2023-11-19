function tm --wraps='tmux' --description 'tmux'
    if set -q argv[1]
        tmux $argv
    else
        tmux attach || tmux new-session
    end
end
