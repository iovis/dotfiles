url := "https://github.com/iovis/dotfiles"

default: init

@list:
    just --list

init:
    git stash push
    git pull
    git stash pop || true

open:
    open {{ url }} || xdg-open {{ url }}
