function par --wraps='sudo pacman -Rs'
    sudo pacman -Rs $argv && pacdump
end
