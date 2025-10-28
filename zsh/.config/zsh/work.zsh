export COMMIT_FEEDBACK=false
export LOCAL_BIN="$HOME/.local/bin"
export PROJECT_HOME="$HOME/co"
export SHOW_RUBY_WARNINGS=true

alias BG="BUNDLE_GEMFILE=$HOME/co/manage/Gemfile.ruby33.rails4"

alias PBJ="PCC_BACKGROUND_JOB_OWNER=$USER"
alias builds="mki build pipelines --artifact rails-42-ruby-33-ubuntu-20 --layer base --limit 3"
alias geminit="chruby-exec ruby-3.3 -- gem install awesome_print pry pry-doc ruby-lsp ruby-lsp-rails solargraph rubocop:1.66.1" # or whatever the bundle says (can conflict with `standard`)
alias gpub="git push origin HEAD:refs/for/master" # ; mki gerrit verify
alias jb="mki git branch --no-fetch"
alias jira="mki jira"
alias n="mise x node@24 --"
alias npminit="n npm install -g \$(cat \$DOTFILES/default/npms)"
alias r3="chruby ruby-3.3"
alias rrg="debe rake routes | rg"

function cargoinit() {
  cargo install -y bat cargo-update difftastic dua-cli eza fd-find hyperfine just muxi ripgrep starship stylua tree-sitter-cli zoxide
}

function libupdate() {
  echo "[$(date '+%Y-%m-%d %H:%M')] Updating zinit"
  zinit update --all

  echo "[$(date '+%Y-%m-%d %H:%M')] Updating cargo packages"
  rustup update
  cargo install-update --all

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Updating mise"
  mise self-update --yes

  INSTALLATION_DIR="/tmp/notdavid_install/"
  LOCAL_BIN="$HOME/.local/bin"

  mkdir -p "$INSTALLATION_DIR"
  cd "$INSTALLATION_DIR" || exit

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing FZF"
  fzf_version=$(curl -LsSf "https://api.github.com/repos/junegunn/fzf/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux_amd64.tar.gz"))')
  curl -Lo fzf.tar.gz "$fzf_version"
  tar xf fzf.tar.gz fzf
  install fzf -D -t "$LOCAL_BIN"
  fzf --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing Lazygit"
  lazygit_version=$(curl -LsSf "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("_linux_x86_64.tar.gz"))')
  curl -Lo lazygit.tar.gz "$lazygit_version"
  tar xf lazygit.tar.gz lazygit
  install lazygit -D -t "$LOCAL_BIN"
  lazygit --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing neovim"
  nvim_version=$(curl -LsSf "https://api.github.com/repos/neovim/neovim-releases/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux-x86_64.appimage"))')
  curl -Lo nvim "$nvim_version"
  install nvim -D -t "$LOCAL_BIN"
  nvim --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing codex"
  codex_version=$(curl -LsSf "https://api.github.com/repos/openai/codex/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("codex-x86_64-unknown-linux-musl.tar.gz"))')
  curl -Lo codex.tar.gz "$codex_version"
  tar xf codex.tar.gz
  mv codex-x86_64-unknown-linux-musl codex
  install codex -D -t "$LOCAL_BIN"
  codex --version

  cd - || exit
  rm -rf "$INSTALLATION_DIR"

  echo "\n[$(date '+%Y-%m-%d %H:%M')] mise outdated"
  mise outdated

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installation ended"
}

if [ -n "$TMUX" ]; then
  function fix_ssh {
    eval $(tmux show-env -s SSH_AUTH_SOCK)
  }
else
  function fix_ssh {}
fi

function preexec {
  fix_ssh
}

v() {
  if [[ "$PWD" == "$HOME/co/manage" ]]; then
    chruby ruby-3.3 || exit

    if [[ $# -gt 0 ]]; then
      BUNDLE_GEMFILE=$HOME/co/manage/Gemfile.ruby33.rails4 nvim $@
    elif [[ -f "Session.vim" ]]; then
      BUNDLE_GEMFILE=$HOME/co/manage/Gemfile.ruby33.rails4 nvim -S Session.vim
    else
      BUNDLE_GEMFILE=$HOME/co/manage/Gemfile.ruby33.rails4 nvim
    fi

    chruby ruby-2.7
  else
    if [[ $# -gt 0 ]]; then
      nvim $@
    elif [[ -f "Session.vim" ]]; then
      nvim -S Session.vim
    else
      nvim
    fi
  fi
}

lspsetup() {
  if [[ "$PWD" == "$HOME/co/manage" ]]; then
    chruby ruby-3.3 || exit
    gem update awesome_print pry pry-doc ruby-lsp ruby-lsp-rails solargraph

    # if this fails do `rm -rf $HOME/.bundle/cache/`
    bundle install --gemfile $HOME/co/manage/Gemfile.ruby33.rails4 --no-prune --no-cache

    gem list '^rubocop$' # is the right version of rubocop installed?
    chruby ruby-2.7
  else
    echo 'Not in manage repo, aborting...'
  fi
}
