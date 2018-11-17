ZSH=$HOME/.oh-my-zsh

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
POWERLEVEL9K_VI_COMMAND_MODE_STRING="echo $'\ue62b'"
POWERLEVEL9K_VI_INSERT_MODE_STRING=''

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  status
  custom_show_apple
  dir
  vcs
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  background_jobs
  virtualenv
  # pyenv
  rbenv
  # time
  command_execution_time
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
# eval "$(pipenv --completion)"

plugins=(
  brew
  bundler
  docker
  docker-compose
  encode64
  eslint
  extract
  gem
  git
  httpie
  jira
  npm
  ng
  osx
  perms
  # pyenv  # slow
  rails
  rbenv  # slow
  rsync
  tig
  tmux
  tmuxinator
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
alias c="bat"
alias canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias d="du -sh"
alias dumpdb="pg_dump -Fc --clean --no-owner -h localhost"
alias files="rg --files -u"
alias fixtrash="rm -rf ~/.Trash; mkdir ~/.Trash; killall Finder"
alias flushcache="dscacheutil -flushcache"
alias flushmemcached="echo 'flush_all' | nc localhost 11211"
alias gcam="git commit -v -am"
alias gcq="git checkout qa"
alias gemo="gem outdated | grep -f ~/.rbenv/default-gems"
alias git=hub
alias gitconfig="$EDITOR ~/.gitconfig"
alias gpr="git pull-request --push --browse -m '' --edit -a iovis9 -b"
alias gprc="git pr checkout"
alias gprs="git pr list"
alias hosts="sudo $EDITOR /etc/hosts"
alias https="http --default-scheme=https"
alias l="exa -lag --git --group-directories-first"
alias libupdate="brew update; brew upgrade; upgrade_oh_my_zsh; powerlevel9k_update; npm -g outdated; echo '\nOutdated gems'; gemo; echo '\nOutdated pips'; pipo"
alias ldbs="listdbs"
alias listdbs="psql -h localhost -c '\l'"
alias ni="nvim"
alias nin="nvim -u ~/.dotfiles/.vimrc_min"
alias nis="nvim -S Session.vim"
alias notes="nvim -c 'Goyo | set filetype=markdown'"
alias npms="npm ls -g --depth=0"
alias npmgo="npm -g outdated"
alias npmgu="npm -g update"
alias powerlevel9k_update="echo '\nUpdating powerlevel9k'; cd ~/.oh-my-zsh/custom/themes/powerlevel9k; gl; cd -"
alias pf="peerflixrb"
alias pipdump="pip freeze > requirements.txt"
alias pipi="pip install"
alias pipinit="pipu pip setuptools && pipr ~/.dotfiles/default-pips"
alias pipo="pip list --outdated --format=columns | grep -f ~/.dotfiles/default-pips"
alias pipr="pip install -r"
alias pipu="pip install -U"
alias pycache="find . -name '*.pyc' -exec rm {} \;"
alias rebuildlaunchservices="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias rsb="rails server -b 0.0.0.0"
alias rtg="rake -T"
alias simulator="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias so="source ~/.zshrc"
alias tailf="tail -f"
alias tmrc="$EDITOR ~/.tmux.conf"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias vimin="vim -u ~/.dotfiles/.vimrc_min"
alias vimrin="vimr --nvim -u ~/.dotfiles/.vimrc_min"
alias vimupdate="nvim +PlugUpgrade +PlugUpdate"
alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
alias zshrc="$EDITOR ~/.zshrc"

# Oh-my-zsh plugin for rails has an alias that clashes with binary rg
unalias rg

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

function snippets() {
  rg $1 ~/.vim/plugged/vim-snippets/**/*.snippets
}

function gprb() {
  if [[ -n $1 ]]; then
    local url="pull/$1"
  else
    local url="pulls"
  fi

  git browse -- $url
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
