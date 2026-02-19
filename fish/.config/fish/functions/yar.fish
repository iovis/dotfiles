function yar --wraps='yay -Rs'
    yay -Rs $argv && pacdump
end
