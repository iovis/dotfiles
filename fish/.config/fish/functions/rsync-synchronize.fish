function rsync-synchronize --wraps='rsync -avzu --delete --progress -h' --description 'alias rsync-synchronize=rsync -avzu --delete --progress -h'
    rsync -avzu --delete --progress -h $argv
end
