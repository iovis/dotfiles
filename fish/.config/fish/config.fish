set -U fish_greeting # remove greeting message

## Environment
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_DATA_HOME $XDG_CONFIG_HOME/.local/share
set -Ux XDG_CACHE_HOME $XDG_CONFIG_HOME/.cache

set -Ux FDOTDIR $XDG_CONFIG_HOME/fish
set -Ux ICLOUD_PATH "$HOME/Library/Mobile Documents/com~apple~CloudDocs"
set -Ux NOTES "$ICLOUD_PATH/notes"

set -Ux DOTFILES "$HOME/.dotfiles"
set -Ux REVIEW_BASE master
set -Ux PROJECT_HOME "$HOME/Sites"
set -Ux EDITOR nvim
set -Ux MANPAGER "$EDITOR +Man!"

set -l preview_command 'bat --style=numbers --color=always {} 2> /dev/null'
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git' -E '.keep' --type file --follow --color=always"
set -Ux FZF_CTRL_T_OPTS "--select-1 --exit-0 --preview '$preview_command' --bind º:toggle-preview"
set -Ux FZF_DEFAULT_OPTS "--ansi --bind=ctrl-n:page-down,ctrl-p:page-up,alt-a:select-all,alt-d:deselect-all,alt-t:toggle-all,home:first,end:last"

set -Ux BAT_THEME "base16"

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
status is-interactive || exit

ulimit -n 12288

source "$FDOTDIR/abbrs.fish"

for local_override in $FDOTDIR/local/*.fish
    source $local_override
end

starship init fish | source
