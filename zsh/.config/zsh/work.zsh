export LOCAL_BIN="$HOME/.local/bin"
export PROJECT_HOME="$HOME/co"
export COMMIT_FEEDBACK=false

alias BG="BUNDLE_GEMFILE=/home/notdavid/co/manage/Gemfile.ruby33.rails4"

alias builds="mki build pipelines --artifact rails-42-ruby-33-ubuntu-20 --layer base --limit 3"
alias gpub="fix_ssh; git push origin HEAD:refs/for/master" # ; mki gerrit verify
alias jb="mki git branch --no-fetch"
alias jira="mki jira"
alias rrg="debe rake routes | rg"
alias geminit="chruby-exec mise-ruby-3.3 -- gem install awesome_print pry pry-doc ruby-lsp ruby-lsp-rails solargraph rubocop:1.66.1" # or whatever the bundle says (can conflict with `standard`)

function cargoinit() {
  curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
  cargo binstall -y bat cargo-update dua-cli eza fd-find git-delta hyperfine just ripgrep starship stylua tree-sitter-cli
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

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing muxi"
  muxi_version=$(curl -LsSf "https://api.github.com/repos/iovis/muxi/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux-musl.tar.xz"))')
  curl -Lo muxi.tar.xz "$muxi_version"
  tar xf muxi.tar.xz
  install muxi*/muxi -D -t "$LOCAL_BIN"
  muxi --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing neovim"
  nvim_version=$(curl -LsSf "https://api.github.com/repos/neovim/neovim-releases/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux-x86_64.appimage"))')
  curl -Lo nvim "$nvim_version"
  install nvim -D -t "$LOCAL_BIN"
  nvim --version

  cd - || exit
  rm -rf "$INSTALLATION_DIR"

  echo "\n[$(date '+%Y-%m-%d %H:%M')] mise outdated"
  mise outdated

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installation ended"
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

v() {
  if [[ "$PWD" == "$HOME/co/manage" ]]; then
    chruby mise-ruby-3.3 || exit

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
  # BUNDLE_GEMFILE=/home/notdavid/co/manage/Gemfile.ruby33.rails4 ruby-lsp --doctor
  if [[ "$PWD" == "$HOME/co/manage" ]]; then
    chruby mise-ruby-3.3 || exit
    gem update awesome_print pry pry-doc ruby-lsp ruby-lsp-rails solargraph
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
