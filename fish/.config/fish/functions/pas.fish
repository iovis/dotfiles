function pas --wraps='sudo pacman -S --needed' --description 'alias pas sudo pacman -S --needed'
    sudo pacman -S --needed $argv && pacmandump
end
