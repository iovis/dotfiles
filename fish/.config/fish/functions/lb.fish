function lb
    lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINTS,MODEL $argv | bat -pp -l conf
end
