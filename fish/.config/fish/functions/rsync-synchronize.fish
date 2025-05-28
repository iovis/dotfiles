function rsync-synchronize --wraps='rsync -avzu --delete --progress -h'
    rsync -avzu --delete --progress -h $argv
end
