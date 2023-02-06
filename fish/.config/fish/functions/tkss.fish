function tkss --wraps='tmux kill-session -t' --description 'alias tkss=tmux kill-session -t'
    tmux kill-session -t $argv
end
