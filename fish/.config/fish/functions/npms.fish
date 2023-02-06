function npms --wraps='npm ls -g --depth=0' --description 'alias npms=npm ls -g --depth=0'
    npm ls -g --depth=0 $argv
end
