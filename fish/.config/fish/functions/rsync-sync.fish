function rsync-sync --wraps='rsync -aiv --progress -h --update --delete'
    rsy $argv
end
