function fishrc --wraps='$EDITOR $FDOTDIR/config.fish' --description 'alias fishrc=$EDITOR $FDOTDIR/config.fish'
    $EDITOR $FDOTDIR/config.fish $argv
end
