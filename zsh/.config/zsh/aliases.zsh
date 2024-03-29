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
alias gcm="git checkout main"
alias gcmsg="git commit -m"
alias gco="git checkout"
alias gcq="git checkout qa"
alias gd="git diff"
alias gdm="git diff main..."
alias gds="git diff --staged"
alias gf="git fetch"
alias gitconfig="\$EDITOR ~/.config/git/config"
alias gl="git pull"
alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'
alias glola='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --all'
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

## quick editing
alias aliases="\$EDITOR \$ZDOTDIR/local/aliases.zsh"
alias hosts="sudo \$EDITOR /etc/hosts"
alias skhdrc="\$EDITOR ~/.config/skhd/skhdrc"
alias so="exec zsh"
alias tmrc="\$EDITOR ~/.config/tmux/tmux.conf"
alias yabairc="\$EDITOR ~/.config/yabai/yabairc"
alias zshrc="\$EDITOR \$ZDOTDIR/.zshrc"

## python
alias activate="source .venv/bin/activate"
alias pedev="pipenv install --dev pylint ipython ipdb pynvim"
alias pesh="pipenv shell"
alias pest="pipenv run start"
alias pipdev="pipu ipdb ipython ruff pynvim pytest"
alias pipdump="pip freeze > requirements.txt"
alias pipi="pip install"
alias pipinit="pipu pip setuptools wheel && pipr \$(cat \$DOTFILES/default/pips)"
alias pipo="pip list --outdated --format=columns | grep --color -f \$DOTFILES/default/pips"
alias pipr="pip install -r"
alias pipu="pip install -U"
alias pycache="find . -name '*.pyc' -exec rm {} \;"
alias pythons="asdf list python"
alias venv="python3 -m venv .venv && activate && pipinit"

## ruby
alias RED="RAILS_ENV=development"
alias REP="RAILS_ENV=production"
alias REQ="RAILS_ENV=qa"
alias RET="RAILS_ENV=test"
alias geminit="gem install \$(cat \$DOTFILES/default/gems)"
alias gemo="gem outdated | grep --color -f \$DOTFILES/default/gems"
alias gems="gem list"
alias rc="rails console"
alias rcg="rails consults:generate --"
alias rcgp="rails consults:generate -- --with-patients"
alias rcs="rails console --sandbox"
alias rdb="rails dbconsole"
alias rdc="rails db:create"
alias rdd="rails db:drop"
alias rdm="rails db:migrate"
alias rdtp="rails db:test:prepare"
alias rgm="rails generate migration"
alias rps="rails parallel:spec"
alias rr="rails routes"
alias rrg="rails routes | g"
alias rsb="rails server -b 0.0.0.0"
alias rsof="rspec --only-failures"
alias rtg="rails -T"
alias rubies="asdf list ruby"

## node
alias nodes="asdf list nodejs"
alias npmci="rm -rf node_modules && npm ci"
alias npmg="npm i -g"
alias npmgo="npm -g outdated"
alias npmgu="npm -g update"
alias npminit="npm install -g \$(cat \$DOTFILES/default/npms)"
alias npms="npm ls -g --depth=0"
alias npmst="npm start"
alias tsinit="yarn add --dev ts-node typescript @types/node"

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

## cpp
alias clang++="clang++ -std=c++17"

## tmux
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias tkg='tmux list-keys | g'
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'
alias tl='tmux list-sessions'
alias tm="tmux attach || tmux new-session"
alias tmsg="tmux display-message"

## rsync
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-synchronize="rsync -avzu --delete --progress -h"
alias rsync-update="rsync -avzu --progress -h"

## misc
alias ag="alias | g --"
alias bell="say ding"
alias c="cat"
alias clean_zsh_cache="rm -f \$ZDOTDIR/**/{.,}*.zwc"
alias ds="du -sh * .* | sort -rh"
alias flushcompletions="rm -f \$ZDOTDIR/.zcompdump*"
alias g="grep -sinr --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"
alias history="fc -liD 1"
alias l="ls -alh"
alias openfiles="ulimit -n 2048"
alias path="echo \$PATH | tr ':' '\n'"
alias t="tree"
alias tailf="tail -f"
alias tmux_plugins="cd $XDG_CONFIG_HOME/tmux/plugins/"
alias vim_plugins="cd $XDG_DATA_HOME/nvim/lazy/"
alias zshcache="clean_zsh_cache; compile_zsh"
