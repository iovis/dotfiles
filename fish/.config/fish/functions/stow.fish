function stow --description alias\ stow=stow\ --ignore=\".+\\.enc\"
    command stow --ignore=".+\.enc" $argv
end
