default: init

@list:
    just --list

init:
    git stash push
    git pull
    git stash pop || true

open:
    open "https://github.com/iovis/dotfiles"
