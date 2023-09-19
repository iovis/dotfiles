function gwc --wraps='git worktree add' --description 'Git worktree checkout'
    git worktree add $argv[1] $argv
end
