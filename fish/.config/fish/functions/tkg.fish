function tkg --wraps='tmux list-keys | g' --description 'alias tkg=tmux list-keys | g'
    tmux list-keys | g $argv
end
