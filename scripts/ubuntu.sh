#!/usr/bin/env sh

# curl --proto '=https' --tlsv1.2 -LsSf https://raw.githubusercontent.com/iovis/dotfiles/master/scripts/ubuntu.sh | sh

export DOTFILES="$HOME/.dotfiles"

echo "[$(date '+%Y-%m-%d %H:%M')] Updating Libraries"
sudo apt update
sudo apt upgrade -y

sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt update

sudo apt install -y build-essential fish gh jq libffi-dev libyaml-dev libz-dev stow tmux

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
cargo binstall -y "$(cat "$DOTFILES/default/crates")"
cargo binstall -y "$(cat "$DOTFILES/default/crates_extra")"

echo "[$(date '+%Y-%m-%d %H:%M')] Installing Lazygit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm -rf lazygit.tar.gz

echo "[$(date '+%Y-%m-%d %H:%M')] Installing FZF"
FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo fzf.tar.gz "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
tar xf fzf.tar.gz fzf
sudo install fzf -D -t /usr/local/bin/
rm -rf fzf.tar.gz fzf

echo "[$(date '+%Y-%m-%d %H:%M')] Installation ended"
