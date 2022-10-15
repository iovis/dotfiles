## PATH
## Avoid duplicates in PATH
typeset -U PATH
typeset -U fpath

# Homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
  # eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

  fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
fi

# asdf
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  source "$HOME/.asdf/asdf.sh"
fi

fpath=("$ASDF_DIR/completions" "${fpath[@]}")

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# dotfiles scripts
export PATH="$HOME/.dotfiles/bin:$PATH"
