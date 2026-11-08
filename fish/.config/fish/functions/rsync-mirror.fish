# Replicate source folder exactly
function rsync-mirror --wraps='rsync -aih --info=progress2 --checksum --delete'
    r --checksum --delete $argv
end
