function cargoinit
    cargo install $(cat $DOTFILES/default/crates)

    if test -n "$RUST_EXTRA"
        cargo install $(cat $DOTFILES/default/crates_extra)
    end
end
