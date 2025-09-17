function pacinit
    sudo pacman -S --needed $(cat $HOME/.config/pacman/Pacfile)
end
