function rrg --wraps='rails routes | g' --description 'alias rrg=rails routes | g'
    rails routes | g $argv
end
