function rsync-sync --wraps='rsync -av --progress -h --update --delete'
    rsync -av --progress -h --update --delete $argv
end
