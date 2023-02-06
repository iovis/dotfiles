function activate --wraps='source .venv/bin/activate' --description 'alias activate=source .venv/bin/activate'
    source .venv/bin/activate $argv
end
