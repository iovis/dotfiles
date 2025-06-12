## PATH
## Avoid duplicates in PATH
typeset -U PATH
typeset -U fpath

if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(SHELL=/bin/zsh /opt/homebrew/bin/brew shellenv)"
fi

if type mise > /dev/null; then
  eval "$(mise activate zsh)"
fi

# dotfiles scripts
export PATH="$HOME/.dotfiles/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
