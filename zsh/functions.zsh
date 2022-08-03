function libupdate() {
  upgrade_libraries
  plugins update
  zshcache

  rustup update
  # cargo install $(cat ~/.dotfiles/default-crates)

  asdf update
  asdf plugin update --all
  asdf reshim

  npm -g outdated

  echo '\nOutdated gems'
  gemo

  echo '\nOutdated pips'
  pipo
}

inode_count() {
  sudo find ${1:-.} -maxdepth 1 -type d | grep -v "^${1:-\.}$" | xargs -n1 -I{} sudo find {} -xdev -type f | sed -n "s:^${1:-\.}::p" | cut -d"/" -f2 | uniq -c | sort -rn
}

rbg() {
  rg "$1" $(bundle list --paths)
}

take() {
  mkdir -p $@ && cd ${@:$#}
}

##
# Set a tmux badge based on the output of a command
#
# Ex: ls;tux [<message>]
tux() {
  tmux set -g @tux_code "$?"
  tmux set -g @tux_show 1
  tmux set -g @tux_message "$*"
}

# We wrap in a local function instead of exporting the variable directly in
# order to avoid interfering with manually-run git commands by the user.
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)

  local ret=$?

  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  || return
  fi

  echo ${ref#refs/heads/}
}

# Function to determine the need of a zcompile. If the .zwc file
# does not exist, or the base file is newer, we need to compile.
# These jobs are asynchronous, and will not impact the interactive shell
zcompare() {
  if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
    zcompile ${1}
  fi
}
