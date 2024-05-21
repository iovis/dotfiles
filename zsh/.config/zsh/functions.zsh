function libupdate() {
  upgrade_libraries
  # plugins update

  rust_update

  # generate_completions
  # zshcache

  # asdf_update

  # npm -g outdated

  # echo '\nOutdated gems'
  # gemo

  # echo '\nOutdated pips'
  # pipo

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
