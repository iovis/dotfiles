function npmgo --wraps='npm -g outdated'
    npm -g outdated $argv
end
