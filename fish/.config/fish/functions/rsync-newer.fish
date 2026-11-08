# Skip regular files newer at destination
# Keep files that are only present in the destination
function rsync-newer --wraps='rsync -aih --info=progress2 --update'
    r --update $argv
end
