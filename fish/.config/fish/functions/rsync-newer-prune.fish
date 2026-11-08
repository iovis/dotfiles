# Skip regular files newer at destination
# Delete files that are only present in the destination
function rsync-newer-prune --wraps='rsync -aih --info=progress2 --update --delete'
    r --update --delete $argv
end
