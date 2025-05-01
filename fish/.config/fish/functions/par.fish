function par --wraps='sudo pacman -Rs' --description 'alias par sudo pacman -Rs'
    sudo pacman -Rs $argv && pacdump
end
