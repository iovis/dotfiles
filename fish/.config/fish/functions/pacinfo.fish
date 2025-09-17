function pacinfo --wraps="pacman -Qi"
    pacman -Qi $argv
end
