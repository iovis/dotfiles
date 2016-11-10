BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"
# ZSH_THEME="avit"
# ZSH_THEME="cloud"
# ZSH_THEME="gentoo"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
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
heroku
nmap
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
)

source $ZSH/oh-my-zsh.sh

# Set vi mode for readline
set -o vi
bindkey "jj" vi-cmd-mode
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey "^[." insert-last-word

# Environment variables
export EDITOR='vim'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LESS="-iMSx4 -FXR"
export MANPAGER="nvim -c 'set ft=man' -"
export PAGER=less
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
# export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.node/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PROJECT_HOME=$HOME/Sites
export RBENV_ROOT="$HOME/.rbenv"
eval "$(rbenv init -)"
eval "$(hub alias -s)"

# Custom aliases
alias d='du -sh'
alias agrep='alias | grep'
alias flushcache="dscacheutil -flushcache"
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias gcam="git commit -v -am"
alias gitconfig="vim ~/.gitconfig"
alias hosts="sudo vim /etc/hosts"
alias libupdate="brew update; brew upgrade; gem update --system; echo '\nOutdated gems'; gem outdated; npm -g outdated; pip list --outdated --format=columns;"
alias pipdump="pip freeze > requirements.txt"
alias pipi="pip install"
alias pipo="pip list --outdated --format=columns"
alias pipu="pip install -U"
alias rebuildlaunchservices="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias zshrc="vim ~/.zshrc"
alias pf='peerflixrb'
alias ni='nvim'
alias kwm='brew services start koekeishiya/kwm/kwm'
alias kwmstop='brew services stop koekeishiya/kwm/kwm'

# Aliases for managing de local development machine
#alias deploy_webserver="sudo httpd -k start; mysql.server start"
#alias undeploy_webserver="sudo httpd -k stop; mysql.server stop"
#alias deploy_webserver="sudo nginx; postgres -D /usr/local/var/postgres;"
#alias undeploy_webserver="sudo nginx -s quit; pg_ctl -D /usr/local/var/postgres stop"
alias deploy_webserver="sudo nginx; mysql.server start; sudo php-fpm &; memcached &"
alias undeploy_webserver="sudo nginx -s quit; mysql.server stop; sudo killall php-fpm; killall memcached"
alias check_webserver="ps auxc | grep -E 'nginx|httpd|mysqld|php-fpm|sshd|memcached|postgres'"
alias restart_webserver="undeploy_webserver && deploy_webserver"

# Disable fucking <C-s> flow control
stty -ixon

# TEVA
alias sync_backend="rsync-synchronize --rsh='ssh -p3105' kgordeev@192.168.240.7:/servicios/var/batch/ser/ /Users/david/Sites/apr2/backend/ser/; rsync-synchronize --rsh='ssh -p3105' kgordeev@192.168.240.7:/servicios/logs/ser/ /Users/david/Sites/apr2/backend/logs/"

# Set the correct file and directory permissions
function chmodfiles() {
  find $1 -type f -print0 | xargs -0 chmod 0644
}

function chmoddirs() {
  find $1 -type d -print0 | xargs -0 chmod 0755
}

# Find OSX junk files
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
