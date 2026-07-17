function pi --wraps="yay -Sii"
    for package in $argv
        log_step $(green $package) info
        yay -Sii $package

        if pacman -Qq -- $package >/dev/null 2>&1
            log_step Installed executables
            pacman -Qlq --color=always -- $package | while read -l f
                if test -f "$f"; and test -x "$f"
                    echo "$f"
                end
            end
        end
    end
end
