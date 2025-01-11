#!/usr/bin/env sh

# curl --proto '=https' --tlsv1.2 -LsSf https://raw.githubusercontent.com/iovis/dotfiles/master/scripts/macos.sh | sh

echo "[$(date '+%Y-%m-%d %H:%M')] Installing Dotfiles"
git clone https://github.com/iovis/dotfiles ~/.dotfiles

echo "[$(date '+%Y-%m-%d %H:%M')] Installing Homebrew"
export NONINTERACTIVE=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file ~/.dotfiles/brew/Brewfile

echo "[$(date '+%Y-%m-%d %H:%M')] Stow"
cd ~/.dotfiles
stow aerospace brew fish git hammerspoon lazygit mise muxi nvim obsidian starship stylua tmux vim wezterm
cd

echo "[$(date '+%Y-%m-%d %H:%M')] Installing mise"
curl https://mise.run | sh
mise install -y

echo "[$(date '+%Y-%m-%d %H:%M')] Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. $HOME/.cargo/env
cargo install cargo-binstall
cargo binstall -y $(cat $DOTFILES/default/crates)

echo "[$(date '+%Y-%m-%d %H:%M')] Installation ended"
