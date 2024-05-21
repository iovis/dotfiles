## Profiling helper
# ZPROF=true zsh -i -c exit
if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

## Environment
export DOTFILES="$HOME/.dotfiles"
export EDITOR="vim"
export REVIEW_BASE="master"

## Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit cdreplay -q

if type starship > /dev/null; then
  eval "$(starship init zsh)"
fi

## Source config files
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/bindkey.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/command_config.zsh"
source "$ZDOTDIR/options.zsh"
source "$ZDOTDIR/completions.zsh"

## Local configuration
# (N.) is so it doesn't error out if it doesn't find anything
for filename in $ZDOTDIR/local/*.zsh(N.); do
  source "$filename"
done

## Profiling helper (keep at the end)
if [[ "$ZPROF" = true ]]; then
  zprof
fi
