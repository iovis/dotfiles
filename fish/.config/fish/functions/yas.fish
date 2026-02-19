function yas --wraps='yay -S'
    yay -S --needed $argv && pacdump
end
