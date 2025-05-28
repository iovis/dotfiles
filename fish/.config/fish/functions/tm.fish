function tm --wraps='tmux'
    if set -q argv[1]
        tmux $argv
    else
        tmux attach || tmux new-session
    end
end
