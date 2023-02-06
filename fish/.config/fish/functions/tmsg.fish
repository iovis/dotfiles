function tmsg --wraps='tmux display-message' --description 'alias tmsg=tmux display-message'
    tmux display-message $argv
end
