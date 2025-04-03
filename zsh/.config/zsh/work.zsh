export LOCAL_BIN="$HOME/.local/bin"
export PROJECT_HOME="$HOME/co"
export COMMIT_FEEDBACK=false

alias BG="BUNDLE_GEMFILE=/home/notdavid/co/manage/Gemfile.ruby33.rails4"

alias builds="mki build systems-status --base-builds"
alias gpub="fix_ssh; git push origin HEAD:refs/for/master" # ; mki gerrit verify
alias jira="mki jira"
alias rrg="debe rake routes | rg"

function libupdate() {
  echo "[$(date '+%Y-%m-%d %H:%M')] Updating zinit"
  zinit update --all

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Updating mise"
  mise self-update --yes

  INSTALLATION_DIR="/tmp/install/"
  LOCAL_BIN="$HOME/.local/bin"

  mkdir -p "$INSTALLATION_DIR"
  cd "$INSTALLATION_DIR" || exit

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing Lazygit"
  lazygit_version=$(curl -LsSf "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("_Linux_x86_64.tar.gz"))')
  curl -Lo lazygit.tar.gz "$lazygit_version"
  tar xf lazygit.tar.gz lazygit
  install lazygit -D -t "$LOCAL_BIN"
  lazygit --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing FZF"
  fzf_version=$(curl -LsSf "https://api.github.com/repos/junegunn/fzf/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux_amd64.tar.gz"))')
  curl -Lo fzf.tar.gz "$fzf_version"
  tar xf fzf.tar.gz fzf
  install fzf -D -t "$LOCAL_BIN"
  fzf --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing neovim"
  # nvim_version=$(curl -LsSf "https://api.github.com/repos/neovim/neovim/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux-x86_64.appimage"))')
  # curl -Lo nvim "$nvim_version"
  curl -Lo nvim "https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.appimage"
  install nvim -D -t "$LOCAL_BIN"
  nvim --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing muxi"
  muxi_version=$(curl -LsSf "https://api.github.com/repos/iovis/muxi/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux-gnu.tar.xz"))')
  curl -Lo muxi.tar.xz "$muxi_version"
  tar xf muxi.tar.xz
  install muxi*/muxi -D -t "$LOCAL_BIN"
  muxi --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing bat"
  bat_version=$(curl -LsSf "https://api.github.com/repos/sharkdp/bat/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-x86_64-unknown-linux-gnu.tar.gz"))')
  curl -Lo bat.tar.gz "$bat_version"
  tar xf bat.tar.gz
  install bat*/bat -D -t "$LOCAL_BIN"
  bat --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing delta"
  delta_version=$(curl -LsSf "https://api.github.com/repos/dandavison/delta/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-x86_64-unknown-linux-gnu.tar.gz"))')
  curl -Lo delta.tar.gz "$delta_version"
  tar xf delta.tar.gz
  install delta*/delta -D -t "$LOCAL_BIN"
  delta --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing eza"
  eza_version=$(curl -LsSf "https://api.github.com/repos/eza-community/eza/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("_x86_64-unknown-linux-gnu.tar.gz"))')
  curl -Lo eza.tar.gz "$eza_version"
  tar xf eza.tar.gz
  install eza -D -t "$LOCAL_BIN"
  eza --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing fd"
  fd_version=$(curl -LsSf "https://api.github.com/repos/sharkdp/fd/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-x86_64-unknown-linux-gnu.tar.gz"))')
  curl -Lo fd.tar.gz "$fd_version"
  tar xf fd.tar.gz
  install fd*/fd -D -t "$LOCAL_BIN"
  fd --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing just"
  just_version=$(curl -LsSf "https://api.github.com/repos/casey/just/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-x86_64-unknown-linux-musl.tar.gz"))')
  curl -Lo just.tar.gz "$just_version"
  tar xf just.tar.gz
  install just -D -t "$LOCAL_BIN"
  just --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing starship"
  starship_version=$(curl -LsSf "https://api.github.com/repos/starship/starship/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-x86_64-unknown-linux-musl.tar.gz"))')
  curl -Lo starship.tar.gz "$starship_version"
  tar xf starship.tar.gz
  install starship -D -t "$LOCAL_BIN"
  starship --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing dua"
  dua_version=$(curl -LsSf "https://api.github.com/repos/Byron/dua-cli/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-x86_64-unknown-linux-musl.tar.gz"))')
  curl -Lo dua.tar.gz "$dua_version"
  tar xf dua.tar.gz
  install dua*/dua -D -t "$LOCAL_BIN"
  dua --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing ast-grep"
  ast_grep_version=$(curl -LsSf "https://api.github.com/repos/ast-grep/ast-grep/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-x86_64-unknown-linux-gnu.zip"))')
  curl -Lo ast_grep.zip "$ast_grep_version"
  unzip ast_grep.zip
  install ast-grep -D -t "$LOCAL_BIN"
  ast-grep --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installation ended"
  cd - || exit
  rm -rf "$INSTALLATION_DIR"
}

upgrade_neovim() {
  INSTALLATION_DIR="/tmp/install/"
  LOCAL_BIN="$HOME/.local/bin"

  mkdir -p "$INSTALLATION_DIR"
  cd "$INSTALLATION_DIR" || exit

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing neovim"
  nvim_version=$(curl -LsSf "https://api.github.com/repos/neovim/neovim/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux-x86_64.appimage"))')
  curl -Lo nvim "$nvim_version"
  chmod +x nvim
  ./nvim --version
}

fix_ssh() {
  eval `tmux show-env | sed -n 's/^\(SSH_[^=]*\)=\(.*\)/export \1="\2"/p'`
}

source ~/co/manage/script/svnmerge_helpers.sh

svnr() {
  fix_ssh

  local orig=`pwd`

  cd ${HOME}/co/manage-released

  svnprep
  svna

  echo "Which revision? "
  read revision

  echo "Creating merge patch - cherry-picking changeset..."
  svnm -r ${revision}

  echo "Release? y/n"
  read confirm

  if [[ "$confirm" == "y" || "$confirm" == "" ]]; then
    echo "Committing release ${revision}..."
    svnc
  fi

  cd $orig
}

n() {
  if [[ "$PWD" == "$HOME/co/manage" ]]; then
    chruby ruby-3.3 || exit

    if [[ $# -gt 0 ]]; then
      BUNDLE_GEMFILE=/home/notdavid/co/manage/Gemfile.ruby33.rails4 nvim $@
    elif [[ -f "Session.vim" ]]; then
      BUNDLE_GEMFILE=/home/notdavid/co/manage/Gemfile.ruby33.rails4 nvim -S Session.vim
    else
      BUNDLE_GEMFILE=/home/notdavid/co/manage/Gemfile.ruby33.rails4 nvim
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
  # BUNDLE_GEMFILE=/home/notdavid/co/manage/Gemfile.ruby33.rails4 BUNDLE_PATH=vendor/bundle-system ruby-lsp --doctor
  if [[ "$PWD" == "$HOME/co/manage" ]]; then
    chruby ruby-3.3 || exit
    gem install awesome_print pry pry-doc ruby-lsp ruby-lsp-rails solargraph rubocop:1.66.1 # or whatever the bundle says (can conflict with `standard`)
    BUNDLE_GEMFILE=/home/notdavid/co/manage/Gemfile.ruby33.rails4 bundle install
    gem list '^rubocop$' # is the right version of rubocop installed?
    chruby ruby-2.7
  else
    echo 'Not in manage repo, aborting...'
  fi
}

sss () {
  fix_ssh
  svnprep
  svna
}
