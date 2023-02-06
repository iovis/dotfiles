function cupdate --wraps='cargo install --locked $(cat $DOTFILES/default/crates)' --description 'alias cupdate=cargo install --locked $(cat $DOTFILES/default/crates)'
    cargo install --locked $(cat $DOTFILES/default/crates) $argv
end
