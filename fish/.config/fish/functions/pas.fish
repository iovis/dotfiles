function pas --wraps='sudo pacman -S --needed'
    sudo pacman -S --needed $argv && pacdump
end
