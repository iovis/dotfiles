function npmgo --wraps='npm -g outdated' --description 'alias npmgo=npm -g outdated'
    npm -g outdated $argv
end
