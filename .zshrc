# Uncomment to profile ZSH startup
# zmodload zsh/zprof

DISABLE_AUTO_UPDATE="true"
HIST_STAMPS="yyyy-mm-dd"
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# Environment variables
export BAT_THEME="base16"
export DOTFILES="$HOME/.dotfiles"
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND="fd -H -E '.git' -E '.keep' --type file --follow --color=always"
export FZF_DEFAULT_OPTS="--ansi --bind=ctrl-p:page-down,ctrl-n:page-up"
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview 'bat --style=numbers --color=always {} 2> /dev/null' --bind º:toggle-preview"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-iMSx4 -FXR"
export MANPAGER="$EDITOR +Man!"
export MANWIDTH=999
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
  fast-syntax-highlighting
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
  you-should-use
  zsh-autosuggestions
  zsh-completions
)

source $ZSH/oh-my-zsh.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Bindkeys
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey "^N" autosuggest-accept
bindkey "^P" forward-word

# Custom aliases
alias agrep="alias | grep"
alias aliases="$EDITOR ~/.zsh/aliases.zsh"
alias c="bat"
alias canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias d="dust -r"
alias dcup="docker-compose up -d --remove-orphans"
alias dumpdb="pg_dump -Fc --clean --no-owner -h localhost"
alias files="fd -H -E '.git' -E '.keep' --type file --follow --color=always"
alias fixtrash="rm -rf ~/.Trash; mkdir ~/.Trash; killall Finder"
alias flushcache="dscacheutil -flushcache"
alias flushredis="redis-cli flushall"
alias gcam="git commit -v -am"
alias gcq="git checkout qa"
alias gemo="gem outdated | grep -f $DOTFILES/default-gems"
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
alias libupdate="brew update; brew upgrade; upgrade_oh_my_zsh; upgrade_plugins; npm -g outdated; echo '\nOutdated gems'; gemo; echo '\nOutdated pips'; pipo"
alias listdbs="psql -h localhost -c '\l'"
alias ni="nvim"
alias nin="nvim -u $DOTFILES/.vimrc_min"
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
alias pipinit="pipu pip setuptools && pipr $DOTFILES/default-pips"
alias pipo="pip list --outdated --format=columns | grep -f $DOTFILES/default-pips"
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
for filename in ~/.zsh/*.zsh; do
  source "$filename"
done

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

function upgrade_plugins() {
  # git clone https://github.com/zdharma/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
  (echo "Upgrading fast-syntax-highlighting" && git -C $ZSH_CUSTOM/plugins/fast-syntax-highlighting pull -q &)

  # git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  (echo "Upgrading zsh-autosuggestions" && git -C $ZSH_CUSTOM/plugins/zsh-autosuggestions pull -q &)

  # git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
  (echo "Upgrading zsh-completions" && git -C $ZSH_CUSTOM/plugins/zsh-completions pull -q &)

  # git clone https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use
  (echo "Upgrading you-should-use" && git -C $ZSH_CUSTOM/plugins/you-should-use pull -q &)

  # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
  (echo "Upgrading powerlevel10k" && git -C $ZSH_CUSTOM/themes/powerlevel10k pull -q &)

  echo "Plugins updated"
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
  flushredis &&
    rails db:drop db:create &&
    psql -h localhost rubicon_development < "${1:-$DUMPS_DIR/latest.dmp}" &&
    rails db:migrate db:test:prepare
}

function rtp() {
  rails parallel:drop parallel:create parallel:prepare
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

[[ ! -f /usr/local/etc/profile.d/z.sh ]] || source /usr/local/etc/profile.d/z.sh
[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

local anchor_files=(
  .git
  .node-version
  .python-version
  .ruby-version
  package.json
)

POWERLEVEL9K_DIR_ANCHOR_BOLD=false
POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=4
POWERLEVEL9K_DIR_HYPERLINK=false
POWERLEVEL9K_DIR_MAX_LENGTH=80
POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=4
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
POWERLEVEL9K_SHORTEN_DELIMITER=
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique

POWERLEVEL9K_RBENV_FOREGROUND='1'
POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=false
POWERLEVEL9K_RBENV_SHOW_SYSTEM=true
POWERLEVEL9K_RBENV_SOURCES=(shell local global)
POWERLEVEL9K_RBENV_VISUAL_IDENTIFIER_EXPANSION=$'\uF219'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir
  vcs
  newline
  background_jobs
  prompt_char
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  command_execution_time
  virtualenv
  rbenv
  context
  newline
)

# Uncomment to profile ZSH startup
# zprof
