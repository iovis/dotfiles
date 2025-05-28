function npms --wraps='npm ls -g --depth=0'
    npm ls -g --depth=0 $argv
end
