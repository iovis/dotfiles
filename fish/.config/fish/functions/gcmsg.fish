function gcmsg --wraps='git commit -m' --description 'alias gcmsg=git commit -m'
    git commit -m $argv
end
