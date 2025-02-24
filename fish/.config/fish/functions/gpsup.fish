function gpsup --wraps='git push --set-upstream origin $(git_current_branch)' --description 'alias gpsup=git push --set-upstream origin $(git_current_branch)'
    git publish $argv
end
