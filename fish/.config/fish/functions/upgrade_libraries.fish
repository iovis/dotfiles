function upgrade_libraries
    if command -q brew
        brew update
        brew upgrade
        brew autoremove
        brewdump
    else if command -q pacman
        log_step $(green pacman) update
        pacupdate

        if command -q paru
            log_step $(green paru) update
            parupdate
        end

        log_step $(green pacman) orpaned
        pacorphan

        gnome-dump-keybindings
        gnome-dump-extensions
    else if command -q apt
        sudo apt update
        sudo apt upgrade -y
    else
        echo 'Define how to upgrade libraries'
        exit 1
    end
end
