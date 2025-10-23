function rsync-update --wraps='rsync -av --progress -h --update'
    rsync -av --progress -h --update $argv
end
