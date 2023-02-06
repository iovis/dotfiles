function gitconfig --wraps='$EDITOR ~/.config/git/config' --description 'alias gitconfig=$EDITOR ~/.config/git/config'
    $EDITOR ~/.config/git/config $argv
end
