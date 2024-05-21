## PATH
## Avoid duplicates in PATH
typeset -U PATH
typeset -U fpath

# dotfiles scripts
export PATH="$HOME/.dotfiles/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
