function parus --wraps='paru -S'
    paru -S --needed --skipreview $argv && parudump
end
