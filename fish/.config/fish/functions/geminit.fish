function geminit --wraps='gem install $(cat $DOTFILES/default/gems)' --description 'alias geminit=gem install $(cat $DOTFILES/default/gems)'
    gem install $(cat $DOTFILES/default/gems) $argv
end
