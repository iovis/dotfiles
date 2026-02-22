function pi --wraps="yay -Sii"
    log_step $(green $argv) info
    yay -Sii $argv

    log_step Installed executables
    pacman -Qlq $argv | while read -l f
        if test -f "$f"; and test -x "$f"
            echo "$f"
        end
    end
end
