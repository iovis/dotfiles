ZSH=$HOME/.oh-my-zsh

# https://github.com/bhilburn/powerlevel9k
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_CUSTOM_SHOW_APPLE="echo "
POWERLEVEL9K_CUSTOM_SHOW_APPLE_BACKGROUND="black"
POWERLEVEL9K_CUSTOM_SHOW_APPLE_FOREGROUND="white"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  status
  custom_show_apple
  # context
  # load
  dir
  # virtualenv
  vcs
  # root_indicator
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  # ip
  # ram
  # docker_machine
  # vi_mode
  background_jobs
  rbenv
  time
  # battery
)

HIST_STAMPS="yyyy-mm-dd"

# Environment variables
export EDITOR="nvim"
export FZF_DEFAULT_OPTS="--bind=ctrl-n:page-down,ctrl-p:page-up"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-iMSx4 -FXR"
export MANPAGER="$EDITOR -c 'set ft=man' -"
export PAGER="less"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/opt/python@2/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PROJECT_HOME="$HOME/Sites"
export RBENV_ROOT="$HOME/.rbenv"

plugins=(
  brew
  bundler
  # colorize
  docker
  docker-compose
  encode64
  eslint
  gem
  git
  httpie
  # jsontools
  npm
  ng
  osx
  perms
  # pip
  # postgres
  rails
  rbenv
  rsync
  tmux
  # tmuxinator
  # virtualenvwrapper
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
bindkey "^N" autosuggest-accept
bindkey "^P" forward-word

# Custom aliases
alias agrep="alias | grep"
alias aliases="$EDITOR ~/.aliases"
alias bcu="brew cask install --force $(brew cask list) && brew cask cleanup"
alias c="pygmentize -O style=native -f console256 -g"
alias canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias d="du -sh"
alias dump="pg_dump -Fc --clean --no-owner -h localhost"
alias files="rg --files -u"
alias fixtrash="rm -rf ~/.Trash; mkdir ~/.Trash; killall Finder"
alias flushcache="dscacheutil -flushcache"
alias flushmemcached="echo 'flush_all' | nc localhost 11211"
alias gcam="git commit -v -am"
alias gemo="gem outdated | grep -f ~/.rbenv/default-gems"
alias git=hub
alias gitconfig="$EDITOR ~/.gitconfig"
alias hosts="sudo $EDITOR /etc/hosts"
alias https="http --default-scheme=https"
alias l="exa -lag --git --group-directories-first"
alias libupdate="brew update; brew upgrade; npm -g outdated; gem update --system; echo '\nOutdated gems'; gemo; pip list --outdated --format=columns"
alias listdbs="psql -h localhost -c '\l'"
alias ni="nvim"
alias nin="nvim -u ~/.dotfiles/.vimrc_min"
alias nis="nvim -S Session.vim"
alias notes="nvim -c 'Goyo | set filetype=markdown'"
alias npms="npm ls -g --depth=0"
alias npmgo="npm -g outdated"
alias npmgu="npm -g update"
alias pf="peerflixrb"
alias pipdump="pip freeze > requirements.txt"
alias pipi="pip install"
alias pipo="pip list --outdated --format=columns"
alias pipu="pip install -U"
alias prs="git browse -- pulls"
alias rebuildlaunchservices="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias rsb="rails server -b 0.0.0.0"
alias rtg="rake -T | grep"
alias so="source ~/.zshrc"
alias tailf="tail -f"
alias tmrc="$EDITOR ~/.tmux.conf"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias vimin="vim -u ~/.dotfiles/.vimrc_min"
alias vimrin="vimr --nvim -u ~/.dotfiles/.vimrc_min"
alias vimupdate="nvim +PlugUpdate +PlugUpgrade +qa"
alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
alias zshrc="$EDITOR ~/.zshrc"

# External aliases
source ~/.aliases

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

# tree
function t() {
  exa --git --group-directories-first -TL${1:-3}
}

function renamedb() {
  psql -h localhost -c "alter database $1 rename to $2"
}

function switchdb() {
  renamedb rubicon_development $1 && renamedb $2 rubicon_development
}

# Codi
# Usage: codi [filetype] [filename]
function codi() {
  nvim $2 -c \
    "set bt=nofile ls=0 noru nonu nornu |\
     hi ColorColumn ctermbg=NONE |\
     hi VertSplit ctermbg=NONE
     hi NonText ctermfg=0 |\
     AirlineToggle |\
     startinsert |\
     Codi ${1:-ruby}"
}

function vader() {
  nvim -c "Vader $1"
}

# Z
. /usr/local/etc/profile.d/z.sh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Keep at the end
# Autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ZSH syntax highlightning
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
