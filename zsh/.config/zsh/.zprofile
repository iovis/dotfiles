## PATH
## Avoid duplicates in PATH
typeset -U PATH
typeset -U fpath

# Homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

  fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# asdf
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  source "$HOME/.asdf/asdf.sh"
fi

fpath=("$ASDF_DIR/completions" "${fpath[@]}")

# dotfiles scripts
export PATH="$HOME/.dotfiles/bin:$PATH"
