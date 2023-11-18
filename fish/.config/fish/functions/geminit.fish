function geminit
    gem update --system
    gem install $(cat $DOTFILES/default/gems)
end
