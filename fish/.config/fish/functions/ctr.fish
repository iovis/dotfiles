function ctr --wraps='cargo nextest run --release' --description 'alias ctr=cargo nextest run --release'
    cargo nextest run --release $argv
end
