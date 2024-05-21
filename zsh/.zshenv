export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/.local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/.cache
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

## rust
if [[ -f $HOME/.cargo/env ]]; then
  . $HOME/.cargo/env
fi
