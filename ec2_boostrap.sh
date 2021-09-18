# EC2 bootstrap script
# git clone https://github.com/iovis/dotfiles ~/.dotfiles
# sh ~/.dotfiles/ec2_boostrap.sh | tee install.log

echo "[$(date '+%Y-%m-%d %H:%M')] Installing system"

# System dependencies
echo "[$(date '+%Y-%m-%d %H:%M')] Installing system dependencies"
sudo apt update
sudo apt -y upgrade
sudo apt install -y automake build-essential byacc cmake gdb gettext lcov libbz2-dev libevent-dev libffi-dev libgdbm-dev liblzma-dev libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev libtool libtool-bin lzma lzma-dev pkg-config protobuf-compiler tk-dev unzip uuid-dev zip zlib1g-dev zsh

# dotfiles
echo "[$(date '+%Y-%m-%d %H:%M')] Linking dotfiles"
sh ~/.dotfiles/link_dotfiles.sh
mkdir ~/.zsh

# Tmux
echo "[$(date '+%Y-%m-%d %H:%M')] Installing tmux"
git clone https://github.com/tmux/tmux
cd tmux
git checkout 3.2a
sh autogen.sh
./configure && make
sudo make install
cd
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# mosh
echo "[$(date '+%Y-%m-%d %H:%M')] Installing mosh"
git clone https://github.com/mobile-shell/mosh
cd mosh
./autogen.sh
./configure
make
sudo make install
cd

# zsh
echo "[$(date '+%Y-%m-%d %H:%M')] Installing Oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# asdf
echo "[$(date '+%Y-%m-%d %H:%M')] Installing asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
. $HOME/.asdf/asdf.sh

asdf update

echo "[$(date '+%Y-%m-%d %H:%M')] Installing ruby"
asdf plugin add ruby
asdf install ruby 2.7.4
asdf global ruby 2.7.4
gem install $(cat ~/.dotfiles/default-gems)

echo "[$(date '+%Y-%m-%d %H:%M')] Installing python"
asdf plugin add python
asdf install python latest
asdf global python latest
pip install -U pip wheel setuptools
pip install -r ~/.dotfiles/default-pips

echo "[$(date '+%Y-%m-%d %H:%M')] Installing node"
asdf plugin add nodejs
asdf install nodejs lts
asdf global nodejs lts
npm -g install npm
npm -g install $(cat ~/.dotfiles/default-npms)

# neovim
echo "[$(date '+%Y-%m-%d %H:%M')] Installing neovim"
git clone https://github.com/neovim/neovim --branch v0.5.0
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd

# rust
echo "[$(date '+%Y-%m-%d %H:%M')] Installing rust"
curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
cargo install $(cat ~/.dotfiles/default-crates)

# gh
echo "[$(date '+%Y-%m-%d %H:%M')] Installing gh"
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
echo "run 'gh auth login' to log in with GitHub"

echo "[$(date '+%Y-%m-%d %H:%M')] Installation ended"
