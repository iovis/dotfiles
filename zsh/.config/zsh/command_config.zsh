# bat
if type bat > /dev/null; then
  export BAT_THEME="base16"
  alias c="bat"
fi

# eza
if type eza > /dev/null; then
  alias l="eza -la --git --group-directories-first --icons"
  alias tree="eza -T --group-directories-first --icons"
fi

# fzf
[[ ! -f "~/.fzf.zsh" ]] || source "~/.fzf.zsh"

if type fzf > /dev/null; then
  preview_command='bat --style=numbers --color=always {} 2> /dev/null'
  export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '$preview_command' --bind=alt-p:toggle-preview"
  export FZF_DEFAULT_COMMAND="fd -H -E '.git' -E '.keep' --type file --follow --color=always"
  export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/fzfrc"
fi

# just
if type just > /dev/null; then
  alias j="just"
  alias jf="just --choose --chooser \"fzf-tmux -p50\%,50\% --prompt 'just> ' --reverse --info inline --preview 'just --show {}' --preview-window 'down'\""
fi

# lazygit
if type lazygit > /dev/null; then
  alias lg="lazygit"
fi

# nvim
if type nvim > /dev/null; then
  export EDITOR="nvim"
  # export MANPAGER="$EDITOR +Man!"

  function v() {
    if [[ $# -gt 0 ]]; then
      nvim $@
    elif [[ -f "Session.vim" ]]; then
      nvim -S Session.vim
    else
      nvim
    fi
  }
fi

# ripgrep
if type rg > /dev/null; then
  alias g="rg -Suu -g '!{.bzr,CVS,.git,.hg,.svn,.idea,.tox}'"
fi

# rust
if type rustc > /dev/null; then
  function rust() {
    name=$(basename $1 .rs)
    rustc $@ && ./$name && rm $name
  }

  function rust_update() {
    rustup update
    cargo install-update --all
  }

  function cargo_init() {
    (cargo binstall --help &> /dev/null) || cargo install cargo-binstall
    cargo binstall -y $(cat $DOTFILES/default/crates)

    [[ -v RUST_EXTRA ]] && cargo binstall -y $(cat $DOTFILES/default/crates_extra)
  }
else
  function rust_update() {
    echo 'No Rust installation detected'
  }
fi
