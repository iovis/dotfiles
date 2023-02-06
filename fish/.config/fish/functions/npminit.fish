function npminit --wraps='npm install -g $(cat $DOTFILES/default/npms)' --description 'alias npminit=npm install -g $(cat $DOTFILES/default/npms)'
    npm install -g $(cat $DOTFILES/default/npms) $argv
end
