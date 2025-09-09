## Environment
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

set -gx DOTFILES "$HOME/.dotfiles"
set -gx FDOTDIR $XDG_CONFIG_HOME/fish
set -gx ICLOUD_PATH "$HOME/Library/Mobile Documents/com~apple~CloudDocs"
set -gx NOTES "$HOME/vaults/io/"
set -gx PROJECT_HOME "$HOME/code"

set -gx EDITOR nvim
set -gx PODMAN_COMPOSE_WARNING_LOGS false

set -l preview_command 'bat --style=numbers,changes --color=always {} 2> /dev/null'
set -gx FZF_CTRL_T_OPTS "--select-1 --exit-0 --preview '$preview_command' --bind=alt-p:toggle-preview"
set -gx FZF_DEFAULT_COMMAND "fd -H -E '.git' -E '.keep' --type file --follow --color=always"
set -gx FZF_DEFAULT_OPTS_FILE "$HOME/.config/fzf/fzfrc"

set -gx JUST_CHOOSER '\
    fzf \
        --prompt="❯ " \
        --header-border \
        --input-border \
        --list-border \
        --info=inline-right \
        --ghost="Just" \
        --reverse \
        --no-input \
        --multi \
        --bind="j:down,k:up" \
        --bind="p,alt-p:toggle-preview" \
        --bind="r,alt-r:change-preview-window(down|right)" \
        --bind="i,/:show-input+unbind(j,k,p,r,i,/)" \
        --preview="just --unstable --color=always --show={}" \
        --preview-window="right:75%" \
        --color=input-border:blue'

## PATH
if test -e /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

fish_add_path $HOME/.dotfiles/bin
fish_add_path $HOME/.local/bin

mise activate fish | source

for local_override in $FDOTDIR/local/*.fish
    source $local_override
end

if not status is-interactive
    return
end

ulimit -n 2048

source $FDOTDIR/abbrs.fish

if command -q fzf
    fzf --fish | source
end

# if command -q tv
#     tv init fish | source
# end

if command -q starship
    starship init fish | source
end

if command -q zoxide
    zoxide init fish | source
end
