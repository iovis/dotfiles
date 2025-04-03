function pase --wraps='pacman -Ss' --description 'alias pase pacman -Ss'
    pacman -Ss $argv
end
