function pipo
    pip list --outdated --format=columns | rg --color=always -wf $DOTFILES/default/pips
end
