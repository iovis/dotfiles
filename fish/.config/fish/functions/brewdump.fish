function brewdump
    brew bundle dump --brews --casks --taps --force --file "$HOME/.config/Brewfile"
end
