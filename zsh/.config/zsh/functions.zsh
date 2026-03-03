function libupdate() {
  upgrade_libraries

  zinit update --all

  rust_update

  mise self-update --yes
  mise outdated

  npm -g outdated

  echo '\nOutdated gems'
  gemo

  echo '\nDone!'
}

function upgrade_libraries() {
}

take() {
  mkdir -p $@ && cd ${@:$#}
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
function zcompare() {
  if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
    zcompile ${1}
  fi
}

function clean_zsh_cache() {
  echo '=== Cleaning ZSH compilation files ==='
  rm -f $ZDOTDIR/**/{.,}*.zwc
  rm -f $ZDOTDIR/.zcompdump*
}

function compile_zsh() {
  echo '=== Compiling ZSH files ==='
  zcompare $ZDOTDIR/.zcompdump
  zcompare $ZDOTDIR/.zshrc
  zcompare $ZDOTDIR/.zprofile

  local file
  for file in $ZDOTDIR/**/*.zsh{,-theme}(N); do
    zcompare "$file"
  done
}
