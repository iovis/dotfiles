function tad --wraps='tmux attach -d -t' --description 'alias tad=tmux attach -d -t'
    tmux attach -d -t $argv
end
