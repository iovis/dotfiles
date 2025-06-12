export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_DISABLE_SSH_CHECK=1
export ZSH_DISABLE_COMPLETION=1

## rust
if [[ -f $HOME/.cargo/env ]]; then
  . $HOME/.cargo/env
fi
