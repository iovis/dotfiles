function upgrade_libraries
    if command -q brew
        brew update
        brew upgrade
        brew autoremove
        brewdump
    else if command -q pacman
        log_step $(green pacman) update
        pacupdate

        if command -q yay
            log_step $(green yay) update
            yayupdate
        end

        pacorphan
    else if command -q apt
        sudo apt update
        sudo apt upgrade -y
    else
        echo 'Define how to upgrade libraries'
        exit 1
    end
end
