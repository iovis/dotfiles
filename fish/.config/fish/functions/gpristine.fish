function gpristine --wraps='git reset --hard && git clean -dffx' --description 'alias gpristine=git reset --hard && git clean -dffx'
    git reset --hard && git clean -dffx $argv
end
