function gcam --wraps='git commit -v -am' --description 'alias gcam=git commit -v -am'
    git commit -v -am $argv
end
