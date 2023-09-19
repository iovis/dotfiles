function gwb --wraps='git worktree add -b' --description 'Git worktree new branch'
    git worktree add -b $argv[1] $argv
end
