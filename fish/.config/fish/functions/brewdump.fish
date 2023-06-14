function brewdump --wraps='cd; brew bundle dump --brews --casks --taps --force; cd -' --description 'alias brewdump=cd; brew bundle dump --brews --casks --taps --force; cd -'
    cd
    brew bundle dump --brews --casks --taps --force
    cd - $argv
end
