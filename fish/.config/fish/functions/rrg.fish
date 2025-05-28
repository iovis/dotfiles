function rrg --wraps='rails routes | rg'
    rails routes | g $argv
end
