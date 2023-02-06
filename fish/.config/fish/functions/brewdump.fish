function brewdump --wraps='cd; brew bundle dump -f; cd -' --description 'alias brewdump=cd; brew bundle dump -f; cd -'
    cd
    brew bundle dump -f
    cd - $argv
end
