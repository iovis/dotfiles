function gnome-dump-keybindings
    dconf dump /org/gnome/desktop/wm/keybindings/ >$DOTFILES/gnome/keybindings
end
