#!/usr/bin/env bash

# Run with: /bin/bash -c "$(curl https://raw.githubusercontent.com/iovis/dotfiles/master/scripts/mac_bootstrap.sh)"

# Homebrew
echo "[$(date '+%Y-%m-%d %H:%M')] Installing Homebrew"
export NONINTERACTIVE=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file ~/.dotfiles/brew/Brewfile

# Dotfiles
echo "[$(date '+%Y-%m-%d %H:%M')] Installing Dotfiles"
git clone https://github.com/iovis/dotfiles ~/.dotfiles

# mise
cd ~/.dotfiles
stow mise
mise upgrade

# rust
echo "[$(date '+%Y-%m-%d %H:%M')] Installing rust"
curl https://sh.rustup.rs -sSf | sh -s -- -y
. $HOME/.cargo/env
cargo install $(cat ~/.dotfiles/default/crates)

echo "[$(date '+%Y-%m-%d %H:%M')] Installation ended"
