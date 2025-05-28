function gcmsg --wraps='git commit -m'
    git commit -m $argv
end
