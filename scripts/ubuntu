#!/usr/bin/env sh

# curl --proto '=https' --tlsv1.2 -LsSf https://raw.githubusercontent.com/iovis/dotfiles/master/scripts/ubuntu.sh | sh

export DOTFILES="$HOME/.dotfiles"
export LOCAL_BIN="$HOME/.local/bin"
export INSTALLATION_DIR="/tmp/install/"
export PATH=$LOCAL_BIN:$PATH

echo "[$(date '+%Y-%m-%d %H:%M')] Updating Libraries"
sudo apt-add-repository -y ppa:fish-shell/release-4
sudo apt update
sudo apt upgrade -y
sudo apt install -y build-essential curl fish git htop jq libffi-dev libfuse2 libyaml-dev libz-dev stow tmux unzip wget
sudo apt remove --autoremove -y snapd

echo "[$(date '+%Y-%m-%d %H:%M')] Installing Dotfiles"
git clone https://github.com/iovis/dotfiles "$DOTFILES"

echo "[$(date '+%Y-%m-%d %H:%M')] Stow"
cd "$DOTFILES" || exit
stow fish fzf git lazygit mise muxi nvim starship stylua tmux vim

echo "[$(date '+%Y-%m-%d %H:%M')] Installing mise"
curl https://mise.run | sh
mise install -y

echo "[$(date '+%Y-%m-%d %H:%M')] Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"
cargo install cargo-binstall
cargo binstall -y $(cat "$DOTFILES/default/crates")
cargo binstall -y $(cat "$DOTFILES/default/crates_extra")

mkdir -p "$INSTALLATION_DIR"
cd "$INSTALLATION_DIR" || exit

echo "[$(date '+%Y-%m-%d %H:%M')] Installing Lazygit"
lazygit_version=$(curl -LsSf "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("_Linux_x86_64.tar.gz"))')
curl -Lo lazygit.tar.gz "$lazygit_version"
tar xf lazygit.tar.gz lazygit
install lazygit -D -t "$LOCAL_BIN"
lazygit --version

echo "[$(date '+%Y-%m-%d %H:%M')] Installing FZF"
fzf_version=$(curl -LsSf "https://api.github.com/repos/junegunn/fzf/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux_amd64.tar.gz"))')
curl -Lo fzf.tar.gz "$fzf_version"
tar xf fzf.tar.gz fzf
install fzf -D -t "$LOCAL_BIN"
fzf --version

echo "[$(date '+%Y-%m-%d %H:%M')] Installing gh"
gh_version=$(curl -LsSf "https://api.github.com/repos/cli/cli/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("_linux_amd64.tar.gz"))')
curl -Lo gh.tar.gz "$gh_version"
tar xf gh.tar.gz
install gh_*_linux_amd64/bin/gh -D -t "$LOCAL_BIN"
gh --version

echo "[$(date '+%Y-%m-%d %H:%M')] Installing neovim"
nvim_version=$(curl -LsSf "https://api.github.com/repos/neovim/neovim/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("-linux-x86_64.appimage"))')
curl -Lo nvim "$nvim_version"
install nvim -D -t "$LOCAL_BIN"
nvim --version

echo "[$(date '+%Y-%m-%d %H:%M')] Installation ended"
cd - || exit
rm -rf "$INSTALLATION_DIR"
