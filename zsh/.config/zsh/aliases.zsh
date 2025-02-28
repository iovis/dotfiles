## directories
for index ({1..9}) alias "$index"="cd +${index}"; unset index # directory stack

alias '..'='cd ..'
alias -- -='cd -'
alias -g ......='../../../../..'
alias -g .....='../../../..'
alias -g ....='../../..'
alias -g ...='../..'
alias d="dirs -v | head -n 10"
alias md="mkdir -p"

## misc
alias ag="alias | g --"
alias c="cat"
alias ds="du -sh * .* | sort -rh"
alias flushcompletions="rm -f \$ZDOTDIR/.zcompdump*"
alias l="ls -alh"
alias openfiles="ulimit -n 2048"
alias path="echo \$PATH | tr ':' '\n'"
alias so="exec zsh"
alias t="which"
alias tailf="tail -f"

## docker
alias dcdn="docker compose down"
alias dcl="docker compose logs"
alias dclf="docker compose logs -f"
alias dcps="docker compose ps"
alias dcstop="docker compose stop"
alias dcup="docker compose up -d --remove-orphans"

## git
alias ga="git add"
alias gb="git branch"
alias gbd="git branch -d"
alias gbr="git branch --remote"
alias gca="git commit --amend --no-edit"
alias gcam="git commit -v -am"
alias gcb="git checkout -b"
alias gcm="git checkout \$(git default-branch)"
alias gcmsg="git commit -m"
alias gco="git checkout"
alias gcq="git checkout qa"
alias gd="git diff"
alias gdm="git diff \$(git default-branch)..."
alias gdn="git diff --no-index"
alias gds="git diff --staged"
alias gf="git fetch"
alias gi="git ignored"
alias gitconfig="\$EDITOR ~/.config/git/config"
alias gl="git pull"
alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'
alias glola='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --all'
alias glos="glol --stat"
alias gls="git log -S"
alias gm="git merge"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpristine="git reset --hard && git clean -dffx"
alias gpsup="git push --set-upstream origin \$(git_current_branch)"
alias grb="git rebase"
alias grbi="git rebase -i"
alias grbia="git rebase -i --autosquash"
alias grbim="git rebase -i --rebase-merges"
alias grf="git reflog"
alias grh="git reset"
alias grhh="git reset --hard"
alias gss="git status -s"
alias gst="git status"
alias gsta="git stash push"
alias gstl="git stash list"
alias gstp="git stash pop"

## python
alias pipi="pip install"
alias pipinit="pipu pip setuptools wheel && pipr \$DOTFILES/default/pips"
alias pipo="pip list --outdated --format=columns | grep --color -f \$DOTFILES/default/pips"
alias pipr="pip install -r"
alias pipu="pip install -U"

## ruby
# alias RED="RAILS_ENV=development"
# alias REP="RAILS_ENV=production"
# alias REQ="RAILS_ENV=qa"
# alias RET="RAILS_ENV=test"
alias geminit="gem install \$(cat \$DOTFILES/default/gems)"
alias gemo="gem outdated | grep --color -f \$DOTFILES/default/gems"
alias gems="gem list"
# alias rc="rails console"
# alias rcg="rails consults:generate --"
# alias rcgp="rails consults:generate -- --with-patients"
# alias rcs="rails console --sandbox"
# alias rdb="rails dbconsole"
# alias rdc="rails db:create"
# alias rdd="rails db:drop"
# alias rdm="rails db:migrate"
# alias rdtp="rails db:test:prepare"
# alias rgm="rails generate migration"
# alias rps="rails parallel:spec"
# alias rr="rails routes"
# alias rrg="rails routes | g"
# alias rsb="rails server -b 0.0.0.0"
# alias rsof="rspec --only-failures"
# alias rtg="rails -T"

## rsync
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-synchronize="rsync -avzu --delete --progress -h"
alias rsync-update="rsync -avzu --progress -h"

## rust
alias cb="cargo build"
alias cbr="cargo build --release"
alias ch="cargo check --all-targets"
alias clippy="cargo clippy -- -W clippy::pedantic -Aclippy::missing-errors-doc -Aclippy::missing-panics-doc"
alias clippyfix="cargo clippy --fix -- -W clippy::pedantic"
alias cr="cargo run --"
alias crq="cargo run -q --"
alias crr="cargo run -q --release --"
alias ct="cargo nextest run"
alias ctr="cargo nextest run --release"
alias cupdate="cargo install --locked \$(cat \$DOTFILES/default/crates)"
alias cw="cargo watch -x 'nextest run'"

ctn() {
  cargo nextest run --nocapture
}

## tmux
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias tkg='tmux list-keys | g'
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'
alias tl='tmux list-sessions'
alias tm="tmux attach || tmux new-session"
alias tmsg="tmux display-message"
