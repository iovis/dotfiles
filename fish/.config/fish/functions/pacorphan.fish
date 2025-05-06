function pacorphan
    pacman -Qtdq || echo 'No orphan packages'
end
