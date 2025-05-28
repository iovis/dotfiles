function gwc --wraps='git worktree add'
    git worktree add $argv[1] $argv
end
