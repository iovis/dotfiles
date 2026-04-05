function n --wraps=nvim
    nvim --clean -u $DOTFILES/minimal.lua $argv
end
