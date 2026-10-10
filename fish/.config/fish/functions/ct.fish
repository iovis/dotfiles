function ct --wraps='cargo nextest run'
    cargo nextest run --cargo-quiet --show-progress only --max-progress-running 0 --no-fail-fast $argv
end
