function gwb --wraps='git worktree add -b'
    git worktree add -b $argv[1] $argv
end
