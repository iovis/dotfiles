function clippyfix --wraps='cargo clippy --fix -- -W clippy::pedantic' --description 'alias clippyfix=cargo clippy --fix -- -W clippy::pedantic'
    cargo clippy --fix -- -W clippy::pedantic $argv
end
