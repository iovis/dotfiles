# Uncomment to profile ZSH startup
# zmodload zsh/zprof

#################
#  Environment  #
#################
DISABLE_AUTO_UPDATE="true"
HIST_STAMPS="yyyy-mm-dd"
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="refined"

export DOTFILES="$HOME/.dotfiles"
export NOTES="$HOME/Library/Mobile Documents/com~apple~CloudDocs/notes/"
export EDITOR="vim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-iMSx4 -FXR"
export NODEJS_CHECK_SIGNATURES="no"
export PAGER="less"
export PROJECT_HOME="$HOME/Sites"
export REVIEW_BASE="master"
export TERM="screen-256color"

plugins=(
  encode64
  extract
  fast-syntax-highlighting
  gem
  git
  npm
  perms
  rsync
  you-should-use
  zsh-autosuggestions
  zsh-completions
)

[[ ! -f ~/.zsh/custom_plugins.zsh ]] || source ~/.zsh/custom_plugins.zsh

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.zsh/custom_theme.zsh ]] || source ~/.zsh/custom_theme.zsh

##############
#  Bindkeys  #
##############
# Disable <C-s> flow control
stty -ixon

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey "^N" autosuggest-accept
bindkey "^P" forward-word
bindkey "^U" backward-kill-line

bindkey -s "^[ñ" '~'
bindkey -s "^[+" ']'
bindkey -s "^[ç" '}'

###########
#  macOS  #
###########
if [[ $OSTYPE == darwin* ]]; then
  if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
  fi

  [[ ! -f /opt/homebrew/bin/brew ]] || eval "$(/opt/homebrew/bin/brew shellenv)"

  export PATH="$HOME/.cargo/bin:$PATH"
  . "$HOME/.cargo/env"

  alias brewdump="cd; brew bundle dump -f; cd -"
  alias notes="cd $NOTES/notes && nvim -S"
  alias fixtrash="rm -rf ~/.Trash; mkdir ~/.Trash; killall Finder"
  alias flushcache="dscacheutil -flushcache"
  alias nt="lsof -Pni"
  alias rebuildlaunchservices="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
  alias repair_permissions="diskutil resetUserPermissions / \$(id -u)"
  alias simulator="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
  alias updatedb="sudo /usr/libexec/locate.updatedb"

  ##
  # airport
  #
  # To capture on a particular channel: airport --channel=4
  # For info of the current tap: airport --getinfo
  # To sniff: airportd en0 sniff
  alias airport="sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
  alias airportd="sudo /usr/libexec/airportd"

  function fix_mosh_server() {
    local fw='/usr/libexec/ApplicationFirewall/socketfilterfw'
    local mosh_sym="$(which mosh-server)"
    # local mosh_abs="$(greadlink -f $mosh_sym)"

    sudo "$fw" --setglobalstate off
    sudo "$fw" --add "$mosh_sym"
    sudo "$fw" --unblockapp "$mosh_sym"
    sudo "$fw" --add "$mosh_abs"
    sudo "$fw" --unblockapp "$mosh_abs"
    sudo "$fw" --setglobalstate on
  }
else
  alias nt="sudo ss -antp"
fi

#############
#  Aliases  #
#############
alias activate="source .venv/bin/activate"
alias ag="alias | g --"
alias aliases="\$EDITOR ~/.zsh/aliases.zsh"
alias d="du -sh * .*"
alias ds="d | sort -rh"
alias gcam="git commit -v -am"
alias gcm="git checkout master"
alias gcq="git checkout qa"
alias gemo="gem outdated | grep -f \$DOTFILES/default-gems"
alias gitconfig="\$EDITOR ~/.gitconfig"
alias gls="git log -S"
alias grbi="git rebase -i --rebase-merges"
alias hosts="sudo \$EDITOR /etc/hosts"
alias npmci="rm -rf node_modules && npm ci"
alias npmgo="npm -g outdated"
alias npmgu="npm -g update"
alias npms="npm ls -g --depth=0"
alias path="echo \$PATH | tr ':' '\n'"
alias pedev="pipenv install --dev pylint ipython ipdb pynvim"
alias pesh="pipenv shell"
alias pest="pipenv run start"
alias pf="peerflixrb"
alias pipdev="pipu ipdb ipython pylint pynvim pytest"
alias pipdump="pip freeze > requirements.txt"
alias pipi="pip install"
alias pipinit="pipu pip setuptools wheel && pipr requirements.txt"
alias pipo="pip list --outdated --format=columns | grep -f \$DOTFILES/default-pips"
alias pipr="pip install -r"
alias pipu="pip install -U"
alias pycache="find . -name '*.pyc' -exec rm {} \;"
alias so="exec zsh"
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias tailf="tail -f"
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'
alias tl='tmux list-sessions'
alias tm="tmux attach || tmux new-session"
alias tmrc="\$EDITOR ~/.tmux.conf"
alias ts='tmux new-session -s'
alias venv="python3 -m venv .venv"
alias zshrc="\$EDITOR ~/.zshrc"

function libupdate() {
  upgrade_libraries

  omz update --unattended
  upgrade_plugins

  rustup update
  cargo install $(cat ~/.dotfiles/default-crates)

  asdf update
  asdf plugin update --all
  asdf reshim

  npm -g outdated

  echo '\nOutdated gems'
  gemo

  echo '\nOutdated pips'
  pipo
}

function upgrade_libraries() {
  brew update
  brew upgrade
}

function upgrade_plugins() {
  BLUE='\033[0;34m'
  GREEN='\033[0;32m'
  NOCOLOR='\033[0m' # No Color

  # git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $ZSH_CUSTOM/plugins/fast-syntax-highlighting
  echo -e "${BLUE}Upgrading ${GREEN}fast-syntax-highlighting${NOCOLOR}" && git -C $ZSH_CUSTOM/plugins/fast-syntax-highlighting pull

  # git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  echo -e "${BLUE}Upgrading ${GREEN}zsh-autosuggestions${NOCOLOR}" && git -C $ZSH_CUSTOM/plugins/zsh-autosuggestions pull

  # git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
  echo -e "${BLUE}Upgrading ${GREEN}zsh-completions${NOCOLOR}" && git -C $ZSH_CUSTOM/plugins/zsh-completions pull

  # git clone https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use
  echo -e "${BLUE}Upgrading ${GREEN}you-should-use${NOCOLOR}" && git -C $ZSH_CUSTOM/plugins/you-should-use pull

  # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
  echo -e "${BLUE}Upgrading ${GREEN}powerlevel10k${NOCOLOR}" && git -C $ZSH_CUSTOM/themes/powerlevel10k pull
}

inode_count() {
  sudo find ${1:-.} -maxdepth 1 -type d | grep -v "^${1:-\.}$" | xargs -n1 -I{} sudo find {} -xdev -type f | sed -n "s:^${1:-\.}::p" | cut -d"/" -f2 | uniq -c | sort -rn
}

rbg() {
  rg "$1" $(bundle list --paths)
}

encrypt() {
  openssl enc -aes-256-cbc -salt -in "$1" -out "$1.enc"
}

decrypt() {
  openssl enc -d -aes-256-cbc -salt -in "$1" -out "$2"
}

#######################
#  Local environment  #
#######################
for filename in ~/.zsh/*.zsh; do
  source "$filename"
done

###########################
#  Command configuration  #
###########################
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  source "$HOME/.asdf/asdf.sh"
elif [[ -f "/usr/local/opt/asdf/asdf.sh" ]]; then
  source "/usr/local/opt/asdf/asdf.sh"
elif [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
  source /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

if type bat > /dev/null; then
  export BAT_THEME="base16"

  alias c="bat"
else
  alias c="cat"
fi

if type exa > /dev/null; then
  alias l="exa -lag --git --group-directories-first"
  alias t="exa --group-directories-first -T"
else
  alias l="ls -alh"
  alias t="tree"
fi

if type fd > /dev/null; then
  if type fzf > /dev/null; then
    export FZF_DEFAULT_COMMAND="fd -H -E '.git' -E '.keep' --type file --follow --color=always"
  fi

  alias f="fd -uu -E '.git' -E '.keep' -tf"
fi

[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh
if type fzf > /dev/null; then
  if type bat > /dev/null; then
    preview_command='bat --style=numbers --color=always {} 2> /dev/null'
  else
    preview_command='cat {} 2> /dev/null'
  fi

  export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '$preview_command' --bind º:toggle-preview"
  export FZF_DEFAULT_OPTS="--ansi --bind=ctrl-n:page-down,ctrl-p:page-up,alt-a:select-all,alt-d:deselect-all,alt-t:toggle-all,home:first,end:last"

  alias af="eval \$(alias | fzf | tr -d \"'\" | cut -d= -f1)"
  alias psf="ps aux | fzf"

  e() {
    IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
  }
fi

if type http > /dev/null; then
  alias https="http --default-scheme=https"
fi

if type hub > /dev/null; then
  alias gpr="git hub pull-request --push --browse -m '' --edit -a iovis -b"
  alias gprc="git hub pr checkout"
  alias gprs="git hub pr list"

  function gprb() {
    if [[ -n $1 ]]; then
      local url="pull/$1"
    else
      local url="pulls"
    fi

    git hub browse -- $url
  }
fi

if type gh > /dev/null; then
  # alias gpr="gh pr create --assignee iovis --base"
  alias gprb="gh pr view --web"
  alias gprc="gh pr checkout"
  alias gprs="gh pr list"
  alias gprss="gh pr status"
  alias pulls="gh pr list --web"
fi

if type nvim > /dev/null; then
  export EDITOR="nvim"
  export MANPAGER="$EDITOR +Man!"
  export MANWIDTH=80

  alias ni="nvim"
  alias nin="nvim -u \$DOTFILES/.vimrc"
  alias nis="nvim -S Session.vim"
  alias note="nvim +ZenMode '+set filetype=markdown'"
fi

if type rg > /dev/null; then
  alias g="rg -Suu"
else
  alias g="grep -sinr"
fi

if type rustc > /dev/null; then
  function rust() {
    name=$(basename $1 .rs)
    rustc $@ && ./$name && rm $name
  }
fi

[[ ! -f /opt/homebrew/etc/profile.d/z.sh ]] || source /opt/homebrew/etc/profile.d/z.sh

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

# Uncomment to profile ZSH startup
# zprof
