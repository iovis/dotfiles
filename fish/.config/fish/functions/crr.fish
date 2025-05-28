function crr --wraps='cargo run -q --release --'
    cargo run --release -- $argv
end
