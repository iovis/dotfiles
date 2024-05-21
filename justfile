default: dev

# lists available tasks
@list:
    just --list

# start the server
dev:
    git stash push
    git pull
    git stash pop

# open the project in the browser
open:
    open "https://github.com/iovis/dotfiles"
