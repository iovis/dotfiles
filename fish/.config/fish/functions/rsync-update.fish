function rsync-update --wraps='rsync -avzu --progress -h'
    rsync -avzu --progress -h $argv
end
