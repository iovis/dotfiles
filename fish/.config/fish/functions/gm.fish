function gm --wraps='git merge --no-ff' --description 'alias gm=git merge --no-ff'
    git merge --no-ff $argv
end
