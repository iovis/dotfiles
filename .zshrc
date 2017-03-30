ZSH=$HOME/.oh-my-zsh

# ZSH_THEME='agnoster'
# https://github.com/bhilburn/powerlevel9k
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_CUSTOM_SHOW_APPLE="echo "
POWERLEVEL9K_CUSTOM_SHOW_APPLE_BACKGROUND="black"
POWERLEVEL9K_CUSTOM_SHOW_APPLE_FOREGROUND="white"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_show_apple
  # context
  # load
  dir
  rbenv
  virtualenv
  vcs
  # root_indicator
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  # ip
  # ram
  # docker_machine
  status
  background_jobs
  vi_mode
  # time
  # battery
)

HIST_STAMPS="yyyy-mm-dd"

plugins=(
  brew
  bundler
  capistrano
  colorize
  docker
  docker-compose
  gem
  git
  git-flow
  gitignore
  grunt
  gulp
  heroku
  httpie
  jsontools
  nmap
  npm
  osx
  pip
  postgres
  python
  rails
  rbenv
  rsync
  ruby
  thefuck
  tmux
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
export EDITOR="vim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-iMSx4 -FXR"
export MANPAGER="nvim -c 'set ft=man' -"
export PAGER="less"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.node/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PROJECT_HOME="$HOME/Sites"
export RBENV_ROOT="$HOME/.rbenv"

eval "$(hub alias -s)"
eval "$(rbenv init -)"
eval "$(thefuck --alias)"

# Custom aliases
alias agrep="alias | grep"
alias bcu="brew cask install --force $(brew cask list) && brew cask cleanup"
alias canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias d="du -sh"
alias flushcache="dscacheutil -flushcache"
alias gcam="git commit -v -am"
alias gitconfig="vim ~/.gitconfig"
alias hosts="sudo vim /etc/hosts"
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
alias restartwebserver="stopwebserver && startwebserver"
alias so="source ~/.zshrc"
alias startwebserver="brew services start nginx; brew services start php70; brew services start mysql; brew services start memcached"
alias statuswebserver="brew services list"
alias stopwebserver="brew services stop nginx; brew services stop php70; brew services stop mysql; brew services stop memcached"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias vimin="vim -u ~/.dotfiles/.vimrc_min"
alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
alias xdebug="vim /usr/local/etc/php/7.0/conf.d/ext-xdebug.ini"
alias zshrc="vim ~/.zshrc"

# Disable fucking <C-s> flow control
stty -ixon

# TEVA
alias sync_ser="rsync-synchronize --rsh='ssh -p3105' kgordeev@192.168.240.7:/servicios/var/batch/ser/ /Users/david/Sites/apr2/backend/ser/; rsync-synchronize --rsh='ssh -p3105' kgordeev@192.168.240.7:/servicios/logs/ser/ /Users/david/Sites/apr2/backend/logs/"

# Set the correct file and directory permissions
function chmodfiles() {
  find $1 -type f -print0 | xargs -0 chmod 0644
}

function chmoddirs() {
  find $1 -type d -print0 | xargs -0 chmod 0755
}

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
