## XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/.local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/.cache

## zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

## yabai
# Needs to be here otherwise it won't pick up this function
_yabai_set_float() {
  if [ $(yabai -m query --windows --window | jq '."is-floating"') != true ]; then
    yabai -m window --toggle float
  fi
}

_yabai_get_window_dimensions() {
  yabai -m query --windows --window | jq '.frame'
}

yabai_send_to_other_display() {
  yabai -m window --display prev || yabai -m window --display last
  yabai -m display --focus prev  || yabai -m display --focus last
}

yabai_grid() {
  _yabai_set_float

  local old_frame=$(yabai -m query --windows --window | jq '.frame')

  yabai -m window --grid $1

  local current_frame=$(yabai -m query --windows --window | jq '.frame')

  # if not changed: Cycle display
  if [[ $old_frame == $current_frame ]]; then
    yabai_send_to_other_display
    yabai -m window --grid $1
  fi
}
