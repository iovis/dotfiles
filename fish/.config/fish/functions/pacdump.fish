function pacdump
    pacman -Qnqe >$HOME/.config/pacman/Pacfile
    pacman -Qmqe >$HOME/.config/pacman/Aurfile
end
