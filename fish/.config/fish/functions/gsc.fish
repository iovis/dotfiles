function gsc
    # Set gamescope priority
    # sudo setcap 'CAP_SYS_NICE=eip' $(which gamescope)
    # gamescope -W 2560 -H 1440 --fullscreen --force-grab-cursor --expose-wayland -- %command%
    gamescope -W 2560 -H 1440 -r 360 --fullscreen --force-grab-cursor --expose-wayland -- $argv
end
