## XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/.local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/.cache

## zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

## yabai
# Needs to be here otherwise it won't pick up this function
if type yabai > /dev/null; then
  set_float() {
    if [ $(yabai -m query --windows --window | jq '."is-floating"') != true ]; then yabai -m window --toggle float; fi
  }
fi
