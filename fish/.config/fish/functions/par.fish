function par --wraps='sudo pacman -R'
    sudo pacman -R $argv && pacdump
end
