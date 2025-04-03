function pacinit
    sudo pacman -S --needed $(cat $DOTFILES/pacman/Pacfile)
end
