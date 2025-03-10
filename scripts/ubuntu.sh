#!/usr/bin/env sh

# curl --proto '=https' --tlsv1.2 -LsSf https://raw.githubusercontent.com/iovis/dotfiles/master/scripts/ubuntu.sh | sh

export DOTFILES="$HOME/.dotfiles"
export LOCAL_BIN="$HOME/.local/bin"
export INSTALLATION_DIR="/tmp/install/"

echo "[$(date '+%Y-%m-%d %H:%M')] Updating Libraries"
sudo apt-add-repository ppa:fish-shell/release-4
sudo apt update
sudo apt upgrade -y
sudo apt install -y build-essential fish jq libffi-dev libfuse2 libyaml-dev libz-dev stow tmux

echo "[$(date '+%Y-%m-%d %H:%M')] Installing Dotfiles"
git clone https://github.com/iovis/dotfiles "$DOTFILES"

echo "[$(date '+%Y-%m-%d %H:%M')] Stow"
cd "$DOTFILES" || exit
stow fish fzf git lazygit mise muxi nvim starship stylua tmux vim
cd || exit

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
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -oP '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit -D -t "$LOCAL_BIN"

echo "[$(date '+%Y-%m-%d %H:%M')] Installing FZF"
FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -oP '"tag_name": *"v\K[^"]*')
curl -Lo fzf.tar.gz "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
tar xf fzf.tar.gz fzf
install fzf -D -t "$LOCAL_BIN"

echo "[$(date '+%Y-%m-%d %H:%M')] Installing gh"
GH_VERSION=$(curl -s "https://api.github.com/repos/cli/cli/releases/latest" | grep -oP '"tag_name": *"v\K[^"]*')
curl -Lo gh.tar.gz "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz"
tar xf gh.tar.gz
install gh_${GH_VERSION}_linux_amd64/bin/gh -D -t "$LOCAL_BIN"

echo "[$(date '+%Y-%m-%d %H:%M')] Installing neovim"
NVIM_VERSION=$(curl -s "https://api.github.com/repos/cli/cli/releases/latest" | grep -oP '"tag_name": *"v\K[^"]*')
curl -Lo nvim "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-x86_64.appimage"
install nvim -D -t "$LOCAL_BIN"

echo "[$(date '+%Y-%m-%d %H:%M')] Installation ended"
cd - || exit
rm -rf "$INSTALLATION_DIR"
