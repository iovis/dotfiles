function paco
    log_step $(green pacman) orphaned
    pacman -Qtdq || echo 'No orphaned packages'
end
