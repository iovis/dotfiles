function crrq --wraps='cargo run -q --release --' --description 'alias crr=cargo run -q --release --'
    cargo run -q --release -- $argv
end
