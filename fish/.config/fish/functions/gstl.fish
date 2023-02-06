function gstl --wraps='git stash list' --description 'alias gstl=git stash list'
    git stash list $argv
end
