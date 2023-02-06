function gbd --wraps='git branch -d' --description 'alias gbd=git branch -d'
    git branch -d $argv
end
