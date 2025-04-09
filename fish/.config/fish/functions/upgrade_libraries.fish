function upgrade_libraries
    if command -q brew
        brew update
        brew upgrade
        brew autoremove
        brewdump
    else if command -q pacman
        sudo pacman -Syu --noconfirm
        pacmandump

        if command -q yay
            yay -Sua --noconfirm
            yaydump
        end

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
