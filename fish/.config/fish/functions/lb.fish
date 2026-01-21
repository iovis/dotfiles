function lb
    lsblk -o NAME,MOUNTPOINTS,SIZE,MODEL $argv | bat -pp -l conf
end
