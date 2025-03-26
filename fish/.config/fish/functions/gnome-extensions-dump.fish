function gnome-extensions-dump
    dconf dump /org/gnome/shell/extensions/ >$DOTFILES/gnome-extensions/conf
end
