function parur --wraps='paru -Rs'
    paru -Rs $argv && parudump
end
