function gstp --wraps='git stash pop'
    git stash pop $argv
end
