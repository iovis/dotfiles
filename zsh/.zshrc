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
export ZSH_PLUGINS="$ZDOTDIR/plugins"
export ZSH_THEME="powerlevel10k"

plugins=(
  romkatv/powerlevel10k
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
)

## Autoload
fpath=("$ZDOTDIR/autoload" "${fpath[@]}")

autoload -Uz compile_zsh

require() {
  [[ ! -f "$1" ]] || source "$1"
}

## Theme
source $ZDOTDIR/themes/$ZSH_THEME.zsh

## Source config files
source "$ZDOTDIR/os_config.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/bindkey.zsh"
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
autoload -U plugins
plugins load

# TODO: why ^A can't be mapped before the plugins load?
bindkey "^A" vi-beginning-of-line
bindkey "^N" autosuggest-accept

## Avoid duplicates in PATH
typeset -U PATH

## Profiling helper (keep at the end)
if [[ "$ZPROF" = true ]]; then
  zprof
fi
