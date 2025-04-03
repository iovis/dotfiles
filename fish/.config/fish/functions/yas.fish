function yas --wraps='sudo yay -S --needed' --description 'alias yas sudo yay -S --needed'
    yay -S --needed $argv && yaydump
end
