function snapshots
    log_step $(green snapper) list
    sudo snapper list

    log_step $(green btrfs) filesystem du -s "/.snapshots/*/snapshot"
    sudo bash -lc 'btrfs filesystem du -s /.snapshots/*/snapshot'
end
