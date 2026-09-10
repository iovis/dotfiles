function upgrade_libraries
    if command -q brew
        brew update
        brew upgrade -y
        brew autoremove
        brewdump
    end

    if command -q pacman
        log_step $(green pacman) update
        pacupdate

        if command -q yay
            log_step $(green yay) update
            yayupdate
        end

        log_step $(green pacman) audit
        pacaudit
    end

    if command -q flatpak
        log_step $(green flatpak) update
        flatpak update --noninteractive
        flatpak uninstall --unused --noninteractive
    end

    if command -q apt
        log_step $(green apt) update
        sudo apt update
        sudo apt upgrade -y
    end

    if command -q gnome-shell
        log_step Exporting $(green GNOME) keybindings
        gnome-keybindings export
    end

    if functions --query upgrade_libraries_after
        # @fish-lsp-disable-next-line 7001
        upgrade_libraries_after
    end
end
