function gsta --wraps='git stash push' --description 'alias gsta=git stash push'
    git stash push $argv
end
