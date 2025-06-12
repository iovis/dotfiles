default: init

@list:
    just --list

init: update_skills update_dotfiles

update_dotfiles:
    git stash push
    git checkout master
    git pull
    git checkout -
    git rebase -
    git stash pop || true

update_skills:
    cd ~/co/skills/meraki-skills/ && git pull
