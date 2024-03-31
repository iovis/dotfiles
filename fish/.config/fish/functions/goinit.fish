function goinit
    # uninstall with `rm $(which command)`
    go install $(cat $DOTFILES/default/gobins)
end
