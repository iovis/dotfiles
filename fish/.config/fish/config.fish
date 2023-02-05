## Environment
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_DATA_HOME $XDG_CONFIG_HOME/.local/share
set -Ux XDG_CACHE_HOME $XDG_CONFIG_HOME/.cache

set -Ux FDOTDIR $XDG_CONFIG_HOME/fish

set -Ux DOTFILES "$HOME/.dotfiles"
set -Ux REVIEW_BASE master
set -Ux PROJECT_HOME "$HOME/Sites"
set -Ux EDITOR nvim

## PATH
if test -f /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
else if test -f /usr/local/bin/brew
    /usr/local/bin/brew shellenv | source
end

if test -f "$HOME/.asdf/asdf.fish"
    source "$HOME/.asdf/asdf.fish"
end

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.dotfiles/bin

## Interactive mode
set -U fish_greeting # remove greeting message
status is-interactive || exit

# TODO: move to ~/.config/starship
set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/zsh/themes/starship.toml
starship init fish | source
