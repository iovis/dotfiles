function crrq --wraps='cargo run -q --release --'
    cargo run -q --release -- $argv
end
