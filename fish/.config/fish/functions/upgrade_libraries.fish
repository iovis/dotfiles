function upgrade_libraries
    if command -q brew
        brew update
        brew upgrade
        brew autoremove
        brewdump
    else if command -q pacman
        sudo pacman -Syu
        pacmandump

        if command -q yay
            yay -Sua
            yaydump
        end
    else if command -q apt
        sudo apt update
        sudo apt upgrade -y
    else
        echo 'Define how to upgrade libraries'
        exit 1
    end
end
