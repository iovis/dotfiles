sudo apt update
sudo apt -y upgrade
sudo apt install -y autoconf automake byacc cmake gcc gcc-c++ git htop libevent-devel libtool ncurses-devel openssl-devel protobuf-compiler protobuf-devel zsh

# Tmux
git clone https://github.com/tmux/tmux
cd tmux
git checkout 3.2a
sh autogen.sh
./configure && make
cd
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# mosh
git clone https://github.com/mobile-shell/mosh
cd mosh
./autogen.sh
./configure
make
sudo make install
cd

# dotfiles
git clone https://github.com/iovis/dotfiles ~/.dotfiles
sh ~/.dotfiles/link_dotfiles.sh
mkdir ~/.zsh

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
. $HOME/.asdf/asdf.sh
asdf update
asdf plugin add ruby
asdf install ruby 2.7.4
asdf global ruby 2.7.4

asdf plugin add python
asdf install python latest
asdf global python latest

asdf plugin add nodejs
asdf install nodejs lts
asdf global nodejs lts

# neovim
git clone https://github.com/neovim/neovim --branch v0.5.0
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd

# python
pip install -U pip wheel setuptools
pip install -r ~/.dotfiles/default-pips

# ruby
gem install $(cat ~/.dotfiles/default-gems)

# node
npm -g install npm
npm -g install $(cat ~/.dotfiles/default-npms)

# rust
curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
cargo install $(cat ~/.dotfiles/default-crates)

# gh
