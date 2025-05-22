function parinit
    paru -S --needed --skipreview $(cat $DOTFILES/pacman/Parufile)
end
