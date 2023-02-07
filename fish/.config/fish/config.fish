# set -U fish_greeting # remove greeting message

## Environment
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $XDG_CONFIG_HOME/.local/share
set -gx XDG_CACHE_HOME $XDG_CONFIG_HOME/.cache

set -gx FDOTDIR $XDG_CONFIG_HOME/fish
set -gx ICLOUD_PATH "$HOME/Library/Mobile Documents/com~apple~CloudDocs"
set -gx NOTES "$ICLOUD_PATH/notes"

set -gx DOTFILES "$HOME/.dotfiles"
set -gx REVIEW_BASE master
set -gx PROJECT_HOME "$HOME/Sites"
set -gx EDITOR nvim
set -gx MANPAGER "$EDITOR +Man!"

set -l preview_command 'bat --style=numbers --color=always {} 2> /dev/null'
set -gx FZF_DEFAULT_COMMAND "fd -H -E '.git' -E '.keep' --type file --follow --color=always"
set -gx FZF_CTRL_T_OPTS "--select-1 --exit-0 --preview '$preview_command' --bind º:toggle-preview"
set -gx FZF_DEFAULT_OPTS "--ansi --bind=ctrl-n:page-down,ctrl-p:page-up,alt-a:select-all,alt-d:deselect-all,alt-t:toggle-all,home:first,end:last"

set -gx BAT_THEME base16

## PATH
if test -f /opt/homebrew/bin/brew
    # /opt/homebrew/bin/brew shellenv | source
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
    set -gx HOMEBREW_REPOSITORY /opt/homebrew
    set -q PATH; or set PATH ''
    set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
    set -q MANPATH; or set MANPATH ''
    set -gx MANPATH /opt/homebrew/share/man $MANPATH
    set -q INFOPATH; or set INFOPATH ''
    set -gx INFOPATH /opt/homebrew/share/info $INFOPATH
else if test -f /usr/local/bin/brew
    # /usr/local/bin/brew shellenv | source
    set -gx HOMEBREW_PREFIX /usr/local
    set -gx HOMEBREW_CELLAR /usr/local/Cellar
    set -gx HOMEBREW_REPOSITORY /usr/local/Homebrew
    set -q PATH; or set PATH ''
    set -gx PATH /usr/local/bin /usr/local/sbin $PATH
    set -q MANPATH; or set MANPATH ''
    set -gx MANPATH /usr/local/share/man $MANPATH
    set -q INFOPATH; or set INFOPATH ''
    set -gx INFOPATH /usr/local/share/info $INFOPATH
end

if test -f "$HOME/.asdf/asdf.fish"
    source "$HOME/.asdf/asdf.fish"
end

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.dotfiles/bin

## Interactive mode
status is-interactive || exit

ulimit -n 2048

source "$FDOTDIR/abbrs.fish"

for local_override in $FDOTDIR/local/*.fish
    source $local_override
end

# starship init fish | source
starship init fish --print-full-init | source
