function gemo --wraps='gem outdated | grep --color -f $DOTFILES/default/gems' --description 'alias gemo=gem outdated | grep --color -f $DOTFILES/default/gems'
    gem outdated | grep --color -f $DOTFILES/default/gems $argv
end
