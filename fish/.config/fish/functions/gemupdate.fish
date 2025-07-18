function gemupdate
    gem update --system
    gem update $(cat $DOTFILES/default/gems)
    gem cleanup
end
