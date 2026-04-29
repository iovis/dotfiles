function gsta --wraps='git stash push --include-untracked'
    git stash push --include-untracked $argv
end
