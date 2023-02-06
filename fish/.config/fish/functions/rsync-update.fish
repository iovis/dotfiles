function rsync-update --wraps='rsync -avzu --progress -h' --description 'alias rsync-update=rsync -avzu --progress -h'
    rsync -avzu --progress -h $argv
end
