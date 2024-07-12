## Environment
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

set -gx FDOTDIR $XDG_CONFIG_HOME/fish
set -gx ICLOUD_PATH "$HOME/Library/Mobile Documents/com~apple~CloudDocs"
set -gx NOTES "$ICLOUD_PATH/notes"

set -gx DOTFILES "$HOME/.dotfiles"
set -gx REVIEW_BASE main
set -gx PROJECT_HOME "$HOME/code"
set -gx EDITOR nvim
set -gx PAGER bat
set -gx MANPAGER "$EDITOR +Man!"

set -l preview_command 'bat --style=numbers --color=always {} 2> /dev/null'
set -gx FZF_DEFAULT_COMMAND "fd -H -E '.git' -E '.keep' --type file --follow --color=always"
set -gx FZF_CTRL_T_OPTS "--select-1 --exit-0 --preview '$preview_command' --bind=alt-p:toggle-preview"

# https://github.com/catppuccin/fzf
# bg:-1,gutter:-1 => transparent
set -gx FZF_DEFAULT_OPTS "\
--ansi \
--bind=ctrl-n:page-down,ctrl-p:page-up \
--bind=alt-a:select-all,alt-d:deselect-all,alt-t:toggle-all \
--bind=home:first,end:last \
--color=bg+:#414559,bg:-1,gutter:-1,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#8caaee,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#8caaee,hl+:#e78284"

set -gx BAT_THEME base16
set -gx MISE_FISH_AUTO_ACTIVATE 0

## PATH
if test -e /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

fish_add_path $HOME/.dotfiles/bin

for local_override in $FDOTDIR/local/*.fish
    source $local_override
end

if status is-interactive
    ulimit -n 2048

    mise activate fish | source

    source "$FDOTDIR/abbrs.fish"

    if command -q fzf
        fzf --fish | source
    end

    if command -q starship
        starship init fish | source
    end

    if command -q zoxide
        zoxide init fish | source
    end

    if command -q atuin
        atuin init fish --disable-up-arrow | source
    end
else
    mise activate fish --shims | source
end
