function ct --wraps='cargo nextest run' --description 'alias ct=cargo nextest run'
    cargo nextest run $argv
end
