#!/usr/bin/env bash

# System dependencies
apt install -y htop nodejs npm tree rename zsh tmux exiftool ripgrep neovim fonts-firacode network-manager-openvpn network-manager-openvpn-gnome

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
cd ~/.fzf
./install

# Tmux plugins
cd
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

# ZSH Plugins
mkdir ~/.zsh
git clone https://github.com/zdharma/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
