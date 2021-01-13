export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.cargo/bin:$PATH"

if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  source "$HOME/.asdf/asdf.sh"
elif [[ -f "/usr/local/opt/asdf/asdf.sh" ]]; then
  source "/usr/local/opt/asdf/asdf.sh"
fi
