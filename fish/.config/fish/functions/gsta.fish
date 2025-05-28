function gsta --wraps='git stash push'
    git stash push $argv
end
