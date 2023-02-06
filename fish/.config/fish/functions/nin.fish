function nin --wraps='nvim --clean -u $HOME/.vimrc' --description 'alias nin=nvim --clean -u $HOME/.vimrc'
    nvim --clean -u $HOME/.vimrc $argv
end
