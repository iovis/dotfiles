function rps --wraps='rails parallel:spec' --description 'alias rps=rails parallel:spec'
    rails parallel:spec[6] $argv
end
