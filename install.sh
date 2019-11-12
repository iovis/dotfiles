# defaults -currentHost write -globalDomain AppleFontSmoothing -int 3

# Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install $(cat ~/.dotfiles/default-brews)

# Fonts
brew tap homebrew/cask-fonts
brew cask install font-firacode-nerd-font-mono

# Powerlevel9k
brew tap sambadevi/powerlevel9k
brew install powerlevel9k

# Tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Python
pip install -U pip wheel setuptools
pip install -r ~/.dotfiles/default-pips
pip3 install pynvim

# Ruby
rbenv install 2.6.3
rbenv global 2.6.3
gem install $(cat ~/.dotfiles/default-gems)

# Node
npm -g install npm
npm -g install $(cat ~/.dotfiles/default-npms)

# Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
