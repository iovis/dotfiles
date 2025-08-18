function parus --wraps='paru -S'
    paru -S --needed $argv && parudump
end
