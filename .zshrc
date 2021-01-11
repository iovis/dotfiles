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
export EDITOR="vim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-iMSx4 -FXR"
export NODEJS_CHECK_SIGNATURES="no"
export PAGER="less"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.cargo/bin:$PATH"
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
  tmux
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
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey "^N" autosuggest-accept
bindkey "^P" forward-word

bindkey -s "^[ñ" '~'
bindkey -s "^[+" ']'
bindkey -s "^[ç" '}'

#############
#  Aliases  #
#############
unalias g

alias ag="alias | g --"
alias aliases="$EDITOR ~/.zsh/aliases.zsh"
alias dcup="docker-compose up -d --remove-orphans"
alias gcam="git commit -v -am"
alias gcm="git checkout master"
alias gcq="git checkout qa"
alias gemo="gem outdated | grep -f $DOTFILES/default-gems"
alias gitconfig="$EDITOR ~/.gitconfig"
alias gls="git log -S"
alias grbi="git rebase -i --rebase-merges"
alias hosts="sudo $EDITOR /etc/hosts"
alias libupdate="brew update; brew upgrade; omz update --unattended; upgrade_plugins; asdf plugin update --all; npm -g outdated; echo '\nOutdated gems'; gemo; echo '\nOutdated pips'; pipo"
alias npmci="rm -rf node_modules && npm ci"
alias npmgo="npm -g outdated"
alias npmgu="npm -g update"
alias npms="npm ls -g --depth=0"
alias pf="peerflixrb"
alias pipdump="pip freeze > requirements.txt"
alias pipi="pip install"
alias pipinit="pipu pip setuptools wheel && pipr $DOTFILES/default-pips"
alias pipo="pip list --outdated --format=columns | grep -f $DOTFILES/default-pips"
alias pipr="pip install -r"
alias pipu="pip install -U"
alias pycache="find . -name '*.pyc' -exec rm {} \;"
alias so="exec zsh"
alias tailf="tail -f"
alias tm="tmux"
alias tmrc="$EDITOR ~/.tmux.conf"
alias vin="vim -u $DOTFILES/.vimrc_min"
alias zshrc="$EDITOR ~/.zshrc"

###########
#  macOS  #
###########
if [[ $OSTYPE == darwin* ]]; then
  alias fixtrash="rm -rf ~/.Trash; mkdir ~/.Trash; killall Finder"
  alias flushcache="dscacheutil -flushcache"
  alias nt="lsof -Pni"
  alias rebuildlaunchservices="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
  alias repair_permissions="diskutil resetUserPermissions / $(id -u)"
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

# External aliases
for filename in ~/.zsh/*.zsh; do
  source "$filename"
done

# Command aliases
if type bat > /dev/null; then
  export BAT_THEME="base16"

  alias c="bat"
else
  alias c="cat"
fi

if type dust > /dev/null; then
  alias d="dust -r"
else
  alias d="du -had1"
fi

if type exa > /dev/null; then
  alias l="exa -lag --git --group-directories-first"
  alias t="exa --group-directories-first -T"
else
  alias l="ls -alh"
  alias t="tree"
fi

if type fd > /dev/null; then
  export FZF_DEFAULT_COMMAND="fd -H -E '.git' -E '.keep' --type file --follow --color=always"

  alias files="fd -H -E '.git' -E '.keep' --type file --follow --color=always"
fi

[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh
if type fzf > /dev/null; then
  export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview 'bat --style=numbers --color=always {} 2> /dev/null' --bind º:toggle-preview"
  export FZF_DEFAULT_OPTS="--ansi --bind=ctrl-p:page-down,ctrl-n:page-up"

  alias af="eval \$(alias | fzf-tmux | awk -F= '{gsub(/'\''/, \"\", \$1); print \$1}')"
  alias psf="ps aux | fzf-tmux"
fi

if type http > /dev/null; then
  alias https="http --default-scheme=https"
fi

if type hub > /dev/null; then
  alias git=hub
  alias gpr="git pull-request --push --browse -m '' --edit -a iovis -b"
  alias gprc="git pr checkout"
  alias gprs="git pr list"

  function gprb() {
    if [[ -n $1 ]]; then
      local url="pull/$1"
    else
      local url="pulls"
    fi

    git browse -- $url
  }
fi

if type nvim > /dev/null; then
  export EDITOR="nvim"
  export MANPAGER="$EDITOR +Man!"
  export MANWIDTH=999

  alias ni="nvim"
  alias nin="nvim -u $DOTFILES/.vimrc_min"
  alias nis="nvim -S Session.vim"
  alias notes="nvim -c \"let g:airline_exclude_filetypes = ['markdown'] | setf markdown | Goyo\""
fi

if type rg > /dev/null; then
  alias g="rg -uu"
else
  alias g="grep -sinr"
fi

[[ ! -f /usr/local/etc/profile.d/z.sh ]] || source /usr/local/etc/profile.d/z.sh

###########
#  Other  #
###########
# Disable <C-s> flow control
stty -ixon

function rust() {
  name=$(basename $1 .rs)
  rustc $@ && ./$name && rm $name
}

function upgrade_plugins() {
  BLUE='\033[0;34m'
  GREEN='\033[0;32m'
  NOCOLOR='\033[0m' # No Color

  # git clone https://github.com/zdharma/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
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

##########
#  Work  #
##########
export DUMPS_DIR="$HOME/Documents/RubiconMD/dumps"

alias dumpdb="pg_dump -Fc --clean --no-owner -h localhost"
alias flushredis="redis-cli flushall"
alias listdbs="psql -h localhost -c '\l'"
alias rsb="rails server -b 0.0.0.0"
alias rtg="rake -T"

function mvdmp() {
  mv ~/Downloads/*_prod.dmp* $DUMPS_DIR
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

function rptp() {
  rails parallel:drop parallel:create parallel:prepare
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

# Uncomment to profile ZSH startup
# zprof
