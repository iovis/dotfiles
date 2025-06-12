url := "https://github.com/iovis/dotfiles"

default: init

@list:
    just --list

init:
    git stash push
    git checkout master
    git pull
    git checkout -
    git rebase -
    git stash pop || true

open:
    open {{ url }} || xdg-open {{ url }}
