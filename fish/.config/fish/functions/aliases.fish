function aliases --wraps='$EDITOR $FDOTDIR/local/aliases.fish' --description 'alias aliases=$EDITOR $FDOTDIR/local/aliases.fish'
    $EDITOR $FDOTDIR/local/aliases.fish $argv
end
