function gcb --wraps='git checkout -b' --description 'alias gcb=git checkout -b'
    git checkout -b $argv
end
