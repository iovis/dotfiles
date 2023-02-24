function pipinit --wraps='pipu pip setuptools wheel && pipr $(cat $DOTFILES/default/pips)' --description 'alias pipinit=pipu pip setuptools wheel && pipr $(cat $DOTFILES/default/pips)'
    pipu pip setuptools wheel && pipr $DOTFILES/default/pips
end
