# asdf
if type asdf > /dev/null; then
  asdf_update() {
    asdf update
    asdf plugin update --all
    asdf reshim
  }
else
  asdf_update() {
    echo 'asdf not installed'
  }
fi

# bat
if type bat > /dev/null; then
  export BAT_THEME="base16"

  alias c="bat"
fi

# brew
if type brew > /dev/null; then
  alias brewdump="cd; brew bundle dump -f; cd -"
fi

# codespell
if type codespell > /dev/null; then
  alias codespell="codespell --skip 'tags,*.dmp'"
fi

# dexios
if type dexios > /dev/null; then
  encrypt() {
    dexios encrypt "$1" "${1}.enc"
  }

  decrypt() {
    dexios decrypt "$1" "${1%.enc}"
  }

  kencrypt() {
    dexios encrypt -k "$DOTFILES/master.key" "$1" "${1}.enc"
  }

  kdecrypt() {
    dexios decrypt -k "$DOTFILES/master.key" "$1" "${1%.enc}"
  }

  encrypt_all() {
    # fd can't find custom commands unless you execute within `zsh -i`
    # {}:  match
    # {.}: match without extension
    fd -H -e enc . $DOTFILES -x dexios encrypt -f -k "$DOTFILES/master.key" "{.}" "{}"
  }

  decrypt_all() {
    fd -H -e enc . $DOTFILES -x dexios decrypt -f -k "$DOTFILES/master.key" "{}" "{.}"
  }
else
  encrypt() {
    openssl enc -aes-256-cbc -salt -in "$1" -out "${1}.enc"
  }

  decrypt() {
    openssl enc -d -aes-256-cbc -salt -in "$1" -out "${1%.enc}"
  }
fi

# evcxr
if type evcxr > /dev/null; then
  alias irust="evcxr"
fi

# exa
if type exa > /dev/null; then
  alias l="exa -lag --git --group-directories-first"
  alias t="exa --group-directories-first -T"
fi

# fd
if type fd > /dev/null; then
  if type fzf > /dev/null; then
    export FZF_DEFAULT_COMMAND="fd -H -E '.git' -E '.keep' --type file --follow --color=always"

    # cd into git repos
    f() {
      folder=($(fd -td --max-depth 2 . $HOME/Sites | fzf-tmux -p80%,80% --query="$*" --select-1 --exit-0 --reverse))
      [[ -n "$folder" ]] && cd "$folder"
    }
  fi
fi

# fzf
require ~/.fzf.zsh

if type fzf > /dev/null; then
  if type bat > /dev/null; then
    preview_command='bat --style=numbers --color=always {} 2> /dev/null'
  else
    preview_command='cat {} 2> /dev/null'
  fi

  export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '$preview_command' --bind º:toggle-preview"
  export FZF_DEFAULT_OPTS="--ansi --bind=ctrl-n:page-down,ctrl-p:page-up,alt-a:select-all,alt-d:deselect-all,alt-t:toggle-all,home:first,end:last"

  alias af="eval \$(alias | fzf | tr -d \"'\" | cut -d= -f1)"
  alias psf="ps aux | fzf"

  e() {
    IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
  }

  gba() {
    branch=($(git branch -a | fzf --query="$*" --select-1 --exit-0 --reverse | sd 'remotes/origin/' ''))
    [[ -n "$branch" ]] && git checkout "$branch"
  }
fi

# hub
if type hub > /dev/null; then
  alias gpr="git hub pull-request --push --browse -m '' --edit -a iovis -b"
  alias gprc="git hub pr checkout"
  alias gprs="git hub pr list"

  function gprb() {
    if [[ -n $1 ]]; then
      local url="pull/$1"
    else
      local url="pulls"
    fi

    git hub browse -- $url
  }
fi

# gh
if type gh > /dev/null; then
  # alias gpr="gh pr create --assignee iovis --base"
  alias gprb="gh pr view --web"
  alias gprc="gh pr checkout"
  alias gprs="gh pr list"
  alias gprss="gh pr status"
  alias pulls="gh pr list --web"
fi

# just
if type just > /dev/null; then
  alias j="just"
fi

# lazygit
if type lazygit > /dev/null; then
  alias lg="lazygit"
fi

# litecli
if type litecli > /dev/null; then
  alias sqli="litecli"
fi

# nvim
if type nvim > /dev/null; then
  export EDITOR="nvim"
  export MANPAGER="$EDITOR +Man!"
  export MANWIDTH=80

  alias ni="nvim"
  alias nin="nvim --clean -u \$HOME/.vimrc"
  alias nis="nvim -S Session.vim"
  alias notes="cd '$NOTES' && nvim -S Session.vim +ZenMode"
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
    cupdate
  }
else
  function rust_update() {
    echo 'No Rust installation detected'
  }
fi

# stow
if type stow > /dev/null; then
  alias stow='stow --ignore=".+\.enc"'
fi

# tldr
if type tldr > /dev/null; then
  if type fzf > /dev/null; then
    tlf() {
      doc=$(tldr --list | fzf --query="$*" --select-1 --exit-0 --reverse)
      [[ -n "$doc" ]] && tldr "$doc"
    }
  fi
fi
