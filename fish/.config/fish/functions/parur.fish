function parur --wraps='paru -Rs'
    paru -Rs $argv && pacdump
end
