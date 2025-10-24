function rsync-update --wraps='rsync -aiv --progress -h --update'
    r --update $argv
end
