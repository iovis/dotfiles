## XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/.local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/.cache
export PATH="/usr/local/bin:$PATH"

## zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
skip_global_compinit=1  # Some OS's call it in /etc/zsh/zshrc

## rust
if [[ -f $HOME/.cargo/env ]]; then
  . $HOME/.cargo/env
fi

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
  sleep 0.1  # seems like there's a race condition
  local current_frame=$(yabai -m query --windows --window | jq '.frame')

  # if not changed: Cycle display
  if [[ $old_frame == $current_frame ]]; then
    yabai_send_to_other_display
    yabai -m window --grid $1
  fi
}

yabai_set_second_display() {
  open -a Fantastical
  yabai -m window --display 2

  open -a Music
  yabai -m window --display 2
  yabai -m window --grid 10:3:0:10:1:1

  open -a Slack
  yabai -m window --display 2
  open -a Slack
  yabai -m window --swap east
  yabai -m space --balance
  yabai -m window --resize left:-250:0
}
