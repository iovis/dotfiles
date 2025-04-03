function yar --wraps='yay -Rs' --description 'alias yar yay -Rs'
    yay -Rs $argv && yaydump
end
