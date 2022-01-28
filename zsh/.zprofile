## PATH
# Homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" "${fpath[@]}")
fi

# asdf
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  source "$HOME/.asdf/asdf.sh"
elif [[ -f "/usr/local/opt/asdf/asdf.sh" ]]; then
  source "/usr/local/opt/asdf/asdf.sh"
elif [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
  source /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

fpath=("$ASDF_DIR/completions" "${fpath[@]}")

# rust
export PATH="$HOME/.cargo/bin:$PATH"
