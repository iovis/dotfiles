function gwp --wraps='git worktree prune' --description 'alias gwp=git worktree prune'
    git worktree prune $argv
end
