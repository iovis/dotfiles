# kali bootstrap script
# git clone https://github.com/iovis/dotfiles ~/.dotfiles
# . ~/.dotfiles/kali_boostrap.sh 2>&1 | tee install.log

echo "[$(date '+%Y-%m-%d %H:%M')] Installing system"

# System dependencies
echo "[$(date '+%Y-%m-%d %H:%M')] Installing system dependencies"
sudo apt update
sudo apt -y full-upgrade
sudo apt install -y automake build-essential byacc cmake gdb gettext lcov libbz2-dev libevent-dev libffi-dev libgdbm-dev liblzma-dev libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev libtool libtool-bin lzma lzma-dev pkg-config protobuf-compiler tk-dev unzip uuid-dev zip zlib1g-dev zsh

# Tmux
echo "[$(date '+%Y-%m-%d %H:%M')] Installing tmux"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# zsh
echo "[$(date '+%Y-%m-%d %H:%M')] Installing Oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $ZSH_CUSTOM/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# dotfiles
echo "[$(date '+%Y-%m-%d %H:%M')] Linking dotfiles"
sh ~/.dotfiles/link_dotfiles.sh
mkdir ~/.zsh
touch ~/.zsh/aliases.zsh
ln -snf $HOME/.dotfiles/.zsh/custom_theme.zsh $HOME/.zsh/custom_theme.zsh

# asdf
echo "[$(date '+%Y-%m-%d %H:%M')] Installing asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
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
git clone https://github.com/neovim/neovim --branch v0.6.0
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd

# rust
echo "[$(date '+%Y-%m-%d %H:%M')] Installing rust"
curl https://sh.rustup.rs -sSf | sh -s -- -y
. $HOME/.cargo/env
cargo install $(cat ~/.dotfiles/default-crates)

echo "[$(date '+%Y-%m-%d %H:%M')] Installation ended"
echo "Run :PackerSync and ~/.local/share/nvim/site/pack/packer/start/fzf/install -all"
