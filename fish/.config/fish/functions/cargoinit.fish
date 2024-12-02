function cargoinit
    if not cargo binstall --help &>/dev/null
        cargo install cargo-binstall
    end

    cargo binstall -y $(cat $DOTFILES/default/crates)

    if test -n "$RUST_EXTRA"
        cargo install -y $(cat $DOTFILES/default/crates_extra)
    end
end
