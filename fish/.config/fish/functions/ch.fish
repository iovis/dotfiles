function ch --wraps='cargo check --all-targets' --description 'alias ch=cargo check --all-targets'
    cargo check --all-targets $argv
end
