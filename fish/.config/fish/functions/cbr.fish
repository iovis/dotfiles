function cbr --wraps='cargo build --release'
    cargo build --release $argv
end
