function gpsup --wraps='git push --set-upstream origin $(git_current_branch)' --description 'alias gpsup=git push --set-upstream origin $(git_current_branch)'
    git push --set-upstream origin $(git_current_branch) $argv
end
