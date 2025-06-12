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
    open "https://github.com/iovis/dotfiles"
