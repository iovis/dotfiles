function paruinit
    paru -S --needed --skipreview $(cat $HOME/.config/pacman/Parufile)
end
