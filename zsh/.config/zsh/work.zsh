export IS_DEV_MACHINE=true
export COMMIT_FEEDBACK=false
export LOCAL_BIN="$HOME/.local/bin"
export PROJECT_HOME="$HOME/co"
export SHOW_RUBY_WARNINGS=true

alias BG="BUNDLE_GEMFILE=$HOME/co/manage/Gemfile.ruby33.rails5"
alias PBJ="PCC_BACKGROUND_JOB_OWNER=$USER"
alias agents="\$EDITOR ~/.codex/AGENTS.md"
alias builds="mki build pipelines --artifact rails-52-ruby-33-ubuntu-20 --layer base --limit 3"
alias co="codex"
alias geminit="gem install awesome_print pry pry-doc ruby-lsp ruby-lsp-rails"
alias gpub="git push origin HEAD:refs/for/master" # ; mki gerrit verify
alias jira="mki jira"
alias rrg="debe rails routes | rg"
alias sdg="ssh -A chc0"

autoload -Uz bashcompinit && bashcompinit

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

function cargoinit() {
  cargo install -y bat cargo-update difftastic dua-cli eza fd-find hyperfine just muxi ripgrep starship stylua tree-sitter-cli zoxide
}

function libupdate() {
  echo "[$(date '+%Y-%m-%d %H:%M')] Updating zinit"
  zinit update --all

  echo "[$(date '+%Y-%m-%d %H:%M')] Compiling ZSH"
  compile_zsh

  echo "[$(date '+%Y-%m-%d %H:%M')] Updating cargo packages"
  rustup update
  cargo install-update --all

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Updating mise"
  mise self-update --yes

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Updating tmux plugins"
  muxi plugins update

  INSTALLATION_DIR="/tmp/notdavid_install/"
  LOCAL_BIN="$HOME/.local/bin"

  mkdir -p "$INSTALLATION_DIR"
  cd "$INSTALLATION_DIR" || exit

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing codex"
  codex_version=$(curl -LsSf "https://api.github.com/repos/openai/codex/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("codex-x86_64-unknown-linux-musl.tar.gz"))')
  curl -Lo codex.tar.gz "$codex_version"
  tar xf codex.tar.gz
  mv codex-x86_64-unknown-linux-musl codex
  install codex -D -t "$LOCAL_BIN"
  codex --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing fzf"
  fzf_version=$(curl -LsSf "https://api.github.com/repos/junegunn/fzf/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux_amd64.tar.gz"))')
  curl -Lo fzf.tar.gz "$fzf_version"
  tar xf fzf.tar.gz fzf
  install fzf -D -t "$LOCAL_BIN"
  fzf --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing lazygit"
  lazygit_version=$(curl -LsSf "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("_linux_x86_64.tar.gz"))')
  curl -Lo lazygit.tar.gz "$lazygit_version"
  tar xf lazygit.tar.gz lazygit
  install lazygit -D -t "$LOCAL_BIN"
  lazygit --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing neovim"
  nvim_version=$(curl -LsSf "https://api.github.com/repos/neovim/neovim-releases/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux-x86_64.appimage"))')
  curl -Lo nvim "$nvim_version"
  # curl -Lo nvim "https://github.com/neovim/neovim-releases/releases/download/v0.11.5/nvim-linux-x86_64.appimage"
  install nvim -D -t "$LOCAL_BIN"
  nvim --version

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installing tmux"
  tmux_version=$(curl -LsSf "https://api.github.com/repos/tmux/tmux-builds/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux-x86_64.tar.gz"))')
  curl -Lo tmux.tar.gz "$tmux_version"
  tar xf tmux.tar.gz tmux
  install tmux -D -t "$LOCAL_BIN"
  tmux -V

  cd - || exit
  rm -rf "$INSTALLATION_DIR"

  echo "\n[$(date '+%Y-%m-%d %H:%M')] mise outdated"
  mise outdated

  echo "\n[$(date '+%Y-%m-%d %H:%M')] Installation ended"
}

v() {
  if [[ "$PWD" == "$HOME/co/manage" ]]; then
    if [[ $# -gt 0 ]]; then
      BUNDLE_GEMFILE=$HOME/co/manage/Gemfile.ruby40.rails5 chruby-exec ruby-4.0 -- nvim $@
    elif [[ -f "Session.vim" ]]; then
      BUNDLE_GEMFILE=$HOME/co/manage/Gemfile.ruby40.rails5 chruby-exec ruby-4.0 -- nvim -S Session.vim
    else
      BUNDLE_GEMFILE=$HOME/co/manage/Gemfile.ruby40.rails5 chruby-exec ruby-4.0 -- nvim
    fi
  elif [[ "$PWD" == "$HOME/co/mki_cli" ]]; then
    if [[ $# -gt 0 ]]; then
      chruby-exec ruby-4.0 -- nvim $@
    elif [[ -f "Session.vim" ]]; then
      chruby-exec ruby-4.0 -- nvim -S Session.vim
    else
      chruby-exec ruby-4.0 -- nvim
    fi
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
    chruby-exec ruby-4.0 -- gem update awesome_print pry pry-doc ruby-lsp ruby-lsp-rails

    # if this fails do `rm -rf $HOME/.bundle/cache/`
    chruby-exec ruby-4.0 -- bundle install --gemfile $HOME/co/manage/Gemfile.ruby40.rails5 --no-cache

    chruby-exec ruby-4.0 -- gem list '^rubocop$' # is the right version of rubocop installed?
  else
    echo 'Not in manage repo, aborting...'
  fi
}

function psf() {
  ps auxf | fzf \
    --header-lines=1 \
    --multi \
    --raw \
    --reverse \
    --bind='enter:become(echo {+2}; sudo kill -9 {+2})'
}

function psv() {
  ps auxf | nvim \
    '+nmap q <cmd>qa!<cr>' \
    '+nmap r <cmd>bd!<cr><cmd>0r !ps auxf<cr>gg' \
    '+nmap K <cmd>lua vim.cmd(\"Tux sudo kill -9 \" .. vim.fn.getline(\".\"):match(\"%d+\"))<cr>' \
    -
}
