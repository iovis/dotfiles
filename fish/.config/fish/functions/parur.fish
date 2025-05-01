function parur --wraps='paru -Rs' --description 'alias parur paru -Rs'
    paru -Rs $argv && parudump
end
