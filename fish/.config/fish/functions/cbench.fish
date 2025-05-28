function cbench --wraps='cargo bench --bench main -- --verbose'
    cargo bench --bench main -- --verbose --noplot $argv
end
