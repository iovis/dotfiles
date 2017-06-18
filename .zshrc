ZSH=$HOME/.oh-my-zsh
ZSH_THEME='agnoster'
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  brew
  bundler
  capistrano
  colorize
  docker
  docker-compose
  encode64
  gem
  git
  git-flow
  github
  gitignore
  grunt
  gulp
  heroku
  httpie
  jsontools
  nmap
  npm
  osx
  perms
  pip
  postgres
  python
  rails
  rbenv
  rsync
  ruby
  thefuck
  tmux
  tmuxinator
  virtualenvwrapper
  websearch
)

source $ZSH/oh-my-zsh.sh

# Set vi mode for readline
set -o vi
bindkey "^?" backward-delete-char
bindkey "^A" vi-digit-or-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^N" up-line-or-beginning-search
bindkey "^P" down-line-or-beginning-search
bindkey "^[." insert-last-word
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey "jj" vi-cmd-mode
bindkey -M vicmd H vi-first-non-blank
bindkey -M vicmd L vi-end-of-line

# Environment variables
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-iMSx4 -FXR"
export MANPAGER="$EDITOR -c 'set ft=man' -"
export PAGER="less"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.node/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PROJECT_HOME="$HOME/Sites"
export RBENV_ROOT="$HOME/.rbenv"

# Custom aliases
alias agrep="alias | grep"
alias bcu="brew cask install --force $(brew cask list) && brew cask cleanup"
alias canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias d="du -sh"
alias flushcache="dscacheutil -flushcache"
alias flushmemcached="echo 'flush_all' | nc localhost 11211"
alias gcam="git commit -v -am"
alias gitconfig="$EDITOR ~/.gitconfig"
alias gemo="gem outdated | grep -f ~/.rbenv/default-gems"
alias hosts="sudo $EDITOR /etc/hosts"
alias https="http --default-scheme=https"
alias libupdate="brew update; brew upgrade; gem update --system; echo '\nOutdated gems'; gem outdated; npm -g outdated; pip list --outdated --format=columns;"
alias ni="nvim"
alias npms="npm ls -g --depth=0"
alias pf="peerflixrb"
alias pipdump="pip freeze > requirements.txt"
alias pipi="pip install"
alias pipo="pip list --outdated --format=columns"
alias pipu="pip install -U"
alias rebuildlaunchservices="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias so="source ~/.zshrc"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias vimin="vim -u ~/.dotfiles/.vimrc_min"
alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
alias zshrc="$EDITOR ~/.zshrc"

# TEVA
alias empresas="ssh -p 3105 jdelsaz@192.168.240.10"
alias empresas_pre="ssh -p 3105 jdelsaz@192.168.243.10"
alias intranet="ssh -p 3105 kgordeev@192.168.240.7"
alias intranet_pre="ssh -p 3105 kgordeev@192.168.243.7"
alias validador="ssh -p 3105 jdelsaz@192.168.240.8"
alias validador_pre="ssh -p 3105 jdelsaz@192.168.243.8"

# Rubicon
alias cdr="cd ~/Sites/rubicon"
alias restartwebserver="stopwebserver && startwebserver"
alias restoredump="pg_restore --verbose --clean --no-acl --no-owner -h localhost -d rubicon_development"
alias start="brew services start postgresql; brew services start memcached"
alias status="brew services list"
alias stop="brew services stop postgresql; brew services stop memcached"
alias tsr="tmuxinator start rubicon_server"

# Rubicon servers
alias demo2="ssh ubuntu@52.207.86.71"
alias demo="ssh ubuntu@52.6.99.70"
alias demowest="ssh ubuntu@52.43.65.31"
alias dev="ssh ubuntu@52.203.137.139"
alias jenkins="ssh jenkins@34.207.114.111"
alias narakaserver="ssh ubuntu@35.160.120.60"
alias purserver="ssh ubuntu@52.202.106.44"
alias sfdph-qa="ssh ubuntu@35.165.146.237"
alias workerdev="ssh ubuntu@54.175.64.198"
alias workerstaging="ssh ubuntu@54.208.3.232"

# Disable fucking <C-s> flow control
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

# OmniFocus
# Do something! @home ::misc #5pm #tomorrow //This is a note
# The ! makes Do something a flagged task. @home sets the context to "home". :: is used for matching a project. Both @ and :: will fuzzy match existing contexts and projects. The first # is used for a defer date, while the second # is for a due date. Both support natural language parsing like the inspector in OmniFocus. Word of caution though, if only one # is present, OmniFocus assumes it's a due date. Lastly, // starts the note for a task.
function of() {
  if [[ $# -eq 0 ]]; then
    open -a "OmniFocus"
    return 0
  else
    osascript 2>/dev/null <<EOF
      tell application "OmniFocus"
        parse tasks into default document with transport text "$@"
      end tell
      return "Your task was successfully added to OmniFocus."
EOF
  fi
}

# Codi
# Usage: codi [filetype] [filename]
codi() {
  vim $2 -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    AirlineToggle |\
    startinsert |\
    Codi ${1:-python}"
}

ncodi() {
  nvim $2 -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    AirlineToggle |\
    startinsert |\
    Codi ${1:-python}"
}

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
