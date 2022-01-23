## Profiling helper
# ZPROF=true zsh -i -c exit
if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

## Environment
export DOTFILES="$HOME/.dotfiles"
export EDITOR="vim"
export HISTFILE="$ZDOTDIR/.zsh_history"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-iMSx4 -FXR"
export PAGER="less"
export PROJECT_HOME="$HOME/Sites"
export REVIEW_BASE="master"
export TERM="screen-256color"
export ZSH_THEME="powerlevel10k"

fpath=("$ZDOTDIR/autoload" "${fpath[@]}")

require() {
  [[ ! -f "$1" ]] || source "$1"
}

## Theme
source $ZDOTDIR/themes/$ZSH_THEME.zsh

## Source config files
source "$ZDOTDIR/os_config.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/command_config.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/options.zsh"
source "$ZDOTDIR/completions.zsh"

## Local configuration
# (N.) is so it doesn't error out if it doesn't find anything
for filename in $ZDOTDIR/local/*.zsh(N.); do
  source "$filename"
done

## Plugins
export ZSH_PLUGINS="$ZDOTDIR/plugins"

plugins=(
  romkatv/powerlevel10k
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
)

autoload -U plugins compile_zsh
plugins load

# Contains binding for zsh-autosuggestions, so must be kept at the end
source "$ZDOTDIR/bindkey.zsh"

if [[ "$ZPROF" = true ]]; then
  zprof
fi
