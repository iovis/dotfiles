function pipo --wraps='pip list --outdated --format=columns | grep --color -f $DOTFILES/default/pips' --description 'alias pipo=pip list --outdated --format=columns | grep --color -f $DOTFILES/default/pips'
    pip list --outdated --format=columns | grep --color -f $DOTFILES/default/pips $argv
end
