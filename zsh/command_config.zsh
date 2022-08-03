# bat
if type bat > /dev/null; then
  export BAT_THEME="base16"

  alias c="bat"
fi

# dexios
if type dexios > /dev/null; then
  encrypt() {
    dexios -e "$1" "${1}.enc"
  }

  decrypt() {
    dexios -d "$1" "${1%.enc}"
  }
else
  encrypt() {
    openssl enc -aes-256-cbc -salt -in "$1" -out "${1}.enc"
  }

  decrypt() {
    openssl enc -d -aes-256-cbc -salt -in "$1" -out "${1%.enc}"
  }
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

# lazygit
if type lazygit > /dev/null; then
  alias gg="lazygit"
fi

# nvim
if type nvim > /dev/null; then
  export EDITOR="nvim"
  export MANPAGER="$EDITOR +Man!"
  export MANWIDTH=80

  alias ni="nvim"
  alias nin="nvim -u \$DOTFILES/.vimrc"
  alias nis="nvim -S Session.vim"
  alias note="nvim +ZenMode '+set filetype=markdown'"
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
fi
