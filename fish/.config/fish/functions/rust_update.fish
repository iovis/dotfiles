function rust_update
    rustup update
    cupdate

    if test -n "$RUST_EXTRA"
        cargo install $(cat ~/.dotfiles/default/crates_extra)
    end
end
