# defaults -currentHost write -globalDomain AppleFontSmoothing -int 3

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install $(cat ~/.dotfiles/default-brews)

# Fonts
brew tap homebrew/cask-fonts
brew cask install font-firacode-nerd-font-mono

# Tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Python
pip install -U pip wheel setuptools
pip install -r ~/.dotfiles/default-pips
pip3 install pynvim

# Ruby
# rbenv install 2.6.3
# rbenv global 2.6.3
# gem install $(cat ~/.dotfiles/default-gems)

# Node
npm -g install npm
npm -g install $(cat ~/.dotfiles/default-npms)

# Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# ZSH Plugins
mkdir ~/.zsh
git clone https://github.com/zdharma/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
