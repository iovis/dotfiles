function gnome-dump-extensions
    dconf dump /org/gnome/shell/extensions/ >$DOTFILES/gnome/extensions
end
