ZSH=$HOME/.oh-my-zsh

HIST_STAMPS="yyyy-mm-dd"

# Environment variables
export BAT_THEME="base16"
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND="fd -H -E '.git' -E '.keep' --type file --follow --color=always"
export FZF_DEFAULT_OPTS="--ansi --bind=ctrl-p:page-down,ctrl-n:page-up"
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview 'bat --style=numbers --color=always {} 2> /dev/null' --bind º:toggle-preview"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-iMSx4 -FXR"
export MANPAGER="$EDITOR -c 'set ft=man' -"
export PAGER="less"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PROJECT_HOME="$HOME/Sites"
export REVIEW_BASE="master"
export TERM="screen-256color"

plugins=(
  aws
  brew
  bundler
  docker
  docker-compose
  encode64
  extract
  gem
  git
  httpie
  jira
  npm
  ng
  osx
  perms
  rails
  rbenv  # slow
  rsync
  tmux
  web-search
)

source $ZSH/oh-my-zsh.sh

# Set vi mode for readline
# set -o vi
# bindkey "^?" backward-delete-char
# bindkey "^A" vi-digit-or-beginning-of-line
# bindkey "^E" vi-end-of-line
# bindkey "^N" up-line-or-beginning-search
# bindkey "^P" down-line-or-beginning-search
# bindkey "^[." insert-last-word
# bindkey "^[OA" up-line-or-beginning-search
# bindkey "^[OB" down-line-or-beginning-search
# bindkey "kj" vi-cmd-mode
# bindkey -M vicmd H vi-first-non-blank
# bindkey -M vicmd L vi-end-of-line
bindkey "^N" autosuggest-accept
bindkey "^P" forward-word

# Custom aliases
alias agrep="alias | grep"
alias aliases="$EDITOR ~/.aliases"
alias c="bat"
alias canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias d="dust -r"
alias dcup="docker-compose up -d --remove-orphans"
alias dumpdb="pg_dump -Fc --clean --no-owner -h localhost"
alias files="fd -H -E '.git' -E '.keep' --type file --follow --color=always"
alias fixtrash="rm -rf ~/.Trash; mkdir ~/.Trash; killall Finder"
alias flushcache="dscacheutil -flushcache"
alias gcam="git commit -v -am"
alias gcq="git checkout qa"
alias gemo="gem outdated | grep -f ~/.dotfiles/default-gems"
alias git=hub
alias gitconfig="$EDITOR ~/.gitconfig"
alias gls="git log -S"
alias gpr="git pull-request --push --browse -m '' --edit -a iovis -b"
alias gprc="git pr checkout"
alias grbi="git rebase -i --rebase-merges"
alias gprs="git pr list"
alias hosts="sudo $EDITOR /etc/hosts"
alias https="http --default-scheme=https"
alias l="exa -lag --git --group-directories-first"
alias libupdate="brew update; brew upgrade; upgrade_oh_my_zsh; npm -g outdated; echo '\nOutdated gems'; gemo; echo '\nOutdated pips'; pipo"
alias listdbs="psql -h localhost -c '\l'"
alias ni="nvim"
alias nin="nvim -u ~/.dotfiles/.vimrc_min"
alias nis="nvim -S Session.vim"
alias notes="nvim -c 'setf markdown | AirlineToggle | Goyo'"
alias npmci="rm -rf node_modules && npm ci"
alias npmgo="npm -g outdated"
alias npmgu="npm -g update"
alias npms="npm ls -g --depth=0"
alias nt="lsof -Pni"
alias pf="peerflixrb"
alias pipdump="pip freeze > requirements.txt"
alias pipi="pip install"
alias pipinit="pipu pip setuptools && pipr ~/.dotfiles/default-pips"
alias pipo="pip list --outdated --format=columns | grep -f ~/.dotfiles/default-pips"
alias pipr="pip install -r"
alias pipu="pip install -U"
alias psf="ps aux|fzf"
alias pycache="find . -name '*.pyc' -exec rm {} \;"
alias rebuildlaunchservices="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias repair_permissions="diskutil resetUserPermissions / $(id -u)"
alias rsb="rails server -b 0.0.0.0"
alias rtg="rake -T"
alias simulator="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias so="source ~/.zshrc"
alias tailf="tail -f"
alias tm="tmux"
alias tmrc="$EDITOR ~/.tmux.conf"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias vin="vim -u ~/.dotfiles/.vimrc_min"
alias vimupdate="nvim +PlugUpgrade +PlugUpdate"
alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
alias zshrc="$EDITOR ~/.zshrc"

##
# airport
#
# To capture on a particular channel: airport --channel=4
# For info of the current tap: airport --getinfo
# To sniff: airportd en0 sniff
alias airport="sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
alias airportd="sudo /usr/libexec/airportd"

# External aliases
source ~/.aliases

# Disable <C-s> flow control
stty -ixon

# Find macOS junk files
function findjunk() {
  find $1 -name ".DS_Store"
  find $1 -name "._*"
}

function rmjunk() {
  find $1 -name ".DS_Store" -exec rm {} \;
  find $1 -name "._*" -exec rm {} \;
}

# tree
function t() {
  exa --group-directories-first -TL${1:-3}
}

function ip() {
  # (command &) executes in parallel without the 'Done' messages
  (echo "local: $(ifconfig en0|awk '/inet/{print $2}')" &)
  (echo "external: $(http -b https://api.ipify.org/)" &)
}

function vader() {
  nvim -c "Vader $1"
}

##########
#  Work  #
##########
export DUMPS_DIR="$HOME/Documents/RubiconMD/dumps"

function mvdmp() {
  mv ~/Downloads/*_prod.dmp.gz $DUMPS_DIR
  gzip -d $DUMPS_DIR/*_prod.dmp.gz
  lndump
}

function lndump() {
  ls -t $DUMPS_DIR/*_prod.dmp | head -1 | xargs -I{} ln -sf {} $DUMPS_DIR/latest.dmp
}

function restoredb() {
  rails db:drop &&
    rails db:create &&
    psql -h localhost rubicon_development < "${1:-$DUMPS_DIR/latest.dmp}" &&
    rails db:migrate &&
    rails db:test:prepare
}

function rtp() {
  rails parallel:drop &&
    rails parallel:create &&
    rails parallel:prepare
}

function grl() {
  git release create -t master -m $(date +%Y-%m-%d) $(date +%Y-%m-%d)
}

function gprb() {
  if [[ -n $1 ]]; then
    local url="pull/$1"
  else
    local url="pulls"
  fi

  git browse -- $url
}

function awsls() {
  aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PrivateIpAddress,PublicIpAddress,Tags[?Key==`Name`].Value[]]' --output json | tr -d '\n[] "' | perl -pe 's/i-/\ni-/g' | tr ',' '\t' | sed -e 's/null/None/g' | grep '^i-' | column -t
}

##########################
#  Plugin configuration  #
##########################

# Z
. /usr/local/etc/profile.d/z.sh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Keep at the end
# Powerlevel9k
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme

# https://github.com/bhilburn/powerlevel9k
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_CUSTOM_SHOW_APPLE="echo $'\ue711'"
POWERLEVEL9K_CUSTOM_SHOW_APPLE_BACKGROUND="black"
POWERLEVEL9K_CUSTOM_SHOW_APPLE_FOREGROUND="white"
POWERLEVEL9K_ETC_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=''
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''
POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_VI_COMMAND_MODE_STRING="\ue62b"
POWERLEVEL9K_VI_INSERT_MODE_STRING=''
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND="red"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  status
  custom_show_apple
  dir
  vcs
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  # vi_mode
  background_jobs
  # virtualenv
  rbenv
  # time
  command_execution_time
)

# Autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ZSH syntax highlightning
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
