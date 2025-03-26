function yai --wraps='sudo yay -S --needed' --description 'alias yai sudo yay -S --needed'
    yay -S --needed $argv
end
