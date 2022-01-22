## Profiling helper
# ZPROF=true zsh -i -c exit
if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

source $ZDOTDIR/theme.zsh

## Environment
export DOTFILES="$HOME/.dotfiles"
export EDITOR="vim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-iMSx4 -FXR"
export PAGER="less"
export PROJECT_HOME="$HOME/Sites"
export REVIEW_BASE="master"
export TERM="screen-256color"

fpath=("$ZDOTDIR/autoload" "${fpath[@]}")

require() {
  [[ ! -f "$1" ]] || source "$1"
}

## Plugins
export ZSH_PLUGINS="$ZDOTDIR/plugins"

plugins=(
  romkatv/powerlevel10k
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
)

autoload -U plugins
plugins source

## Source config files
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/bindkey.zsh"
source "$ZDOTDIR/command_config.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/options.zsh"
source "$ZDOTDIR/os_config.zsh"

## Local configuration
# (N.) is so it doesn't error out if it doesn't find anything
for filename in $ZDOTDIR/local/*.zsh(N.); do
  source "$filename"
done

if [[ "$ZPROF" = true ]]; then
  zprof
fi
