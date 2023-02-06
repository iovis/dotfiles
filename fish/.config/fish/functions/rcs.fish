function rcs --wraps='rails console --sandbox' --description 'alias rcs=rails console --sandbox'
    rails console --sandbox $argv
end
