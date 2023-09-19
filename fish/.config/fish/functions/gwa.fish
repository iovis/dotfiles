function gwa --wraps='git worktree add' --description 'alias gwa=git worktree add'
    git worktree add $argv
end
