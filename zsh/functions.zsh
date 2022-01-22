function libupdate() {
  upgrade_libraries

  plugins update

  rustup update
  cargo install $(cat ~/.dotfiles/default-crates)

  asdf update
  asdf plugin update --all
  asdf reshim

  npm -g outdated

  echo '\nOutdated gems'
  gemo

  echo '\nOutdated pips'
  pipo
}

function upgrade_libraries() {
  brew update
  brew upgrade

  # brewdump
  cd; brew bundle dump -f; cd -
}

inode_count() {
  sudo find ${1:-.} -maxdepth 1 -type d | grep -v "^${1:-\.}$" | xargs -n1 -I{} sudo find {} -xdev -type f | sed -n "s:^${1:-\.}::p" | cut -d"/" -f2 | uniq -c | sort -rn
}

rbg() {
  rg "$1" $(bundle list --paths)
}

encrypt() {
  openssl enc -aes-256-cbc -salt -in "$1" -out "$1.enc"
}

decrypt() {
  openssl enc -d -aes-256-cbc -salt -in "$1" -out "$2"
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
