function parus --wraps='paru -S'
    paru -S --needed $argv && pacdump
end
