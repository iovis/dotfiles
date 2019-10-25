#!/usr/bin/env bash

# System dependencies
apt install -y htop nodejs npm tree rename zsh tmux exiftool ripgrep neovim zsh-autosuggestions zsh-syntax-highlighting fonts-firacode network-manager-openvpn network-manager-openvpn-gnome

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
cd ~/.fzf
./install
cd

# Tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Python
pip install -U pip wheel setuptools
pip install -r ~/.dotfiles/default-pips
pip3 install pynvim

# Ruby
gem install $(cat ~/.dotfiles/default-gems)

# Node
npm -g install npm
npm -g install $(cat ~/.dotfiles/default-npms)

# Oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
