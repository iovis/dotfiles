#!/usr/bin/env bash

# Run with: /bin/bash -c "$(curl https://raw.githubusercontent.com/iovis/dotfiles/master/scripts/mac_bootstrap.sh)"

# Dotfiles
echo "[$(date '+%Y-%m-%d %H:%M')] Installing Dotfiles"
git clone https://github.com/iovis/dotfiles ~/.dotfiles

# Homebrew
echo "[$(date '+%Y-%m-%d %H:%M')] Installing Homebrew"
export NONINTERACTIVE=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file ~/.dotfiles/brew/Brewfile

# tmux
echo "[$(date '+%Y-%m-%d %H:%M')] Installing Tmux TPM"
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Link dotfiles
echo "[$(date '+%Y-%m-%d %H:%M')] Linking dotfiles"
~/.dotfiles/install

# asdf
echo "[$(date '+%Y-%m-%d %H:%M')] Installing asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
. $HOME/.asdf/asdf.sh
asdf update

echo "[$(date '+%Y-%m-%d %H:%M')] Installing asdf languages"
asdf plugin add ruby
asdf plugin add python
asdf plugin add nodejs

asdf plugin update --all
asdf install

gem update --system
gem install $(cat ~/.dotfiles/default/gems)

pip install -U pip wheel setuptools
pip install -r ~/.dotfiles/default/pips

npm -g install npm
npm -g install $(cat ~/.dotfiles/default/npms)

asdf reshim

# rust
echo "[$(date '+%Y-%m-%d %H:%M')] Installing rust"
curl https://sh.rustup.rs -sSf | sh -s -- -y
. $HOME/.cargo/env
cargo install $(cat ~/.dotfiles/default/crates)

# Encrypted secrets
echo 'place master.key'

echo "[$(date '+%Y-%m-%d %H:%M')] Installation ended"
