function parus --wraps='sudo paru -S --needed' --description 'alias yas sudo paru -S --needed'
    paru -S --needed $argv && parudump
end
