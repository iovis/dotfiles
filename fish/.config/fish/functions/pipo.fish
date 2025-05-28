function pipo
    pip list --outdated --format=columns | grep --color -f $DOTFILES/default/pips
end
