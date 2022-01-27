## XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/.local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/.cache

## zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

## PATH
export PATH="$HOME/.cargo/bin:$PATH"

# TODO: use 'require'?
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  source "$HOME/.asdf/asdf.sh"
elif [[ -f "/usr/local/opt/asdf/asdf.sh" ]]; then
  source "/usr/local/opt/asdf/asdf.sh"
elif [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
  source /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

## Python virtual envs
# TODO: do I need this?
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# yabai
# TODO: does this need to be here?
set_float() {
  if [ $(yabai -m query --windows --window | jq '."is-floating"') != true ]; then yabai -m window --toggle float; fi
}
