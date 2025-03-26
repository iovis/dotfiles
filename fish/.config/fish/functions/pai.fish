function pai --wraps='sudo pacman -S --needed' --description 'alias pai sudo pacman -S --needed'
    sudo pacman -S --needed $argv
end
