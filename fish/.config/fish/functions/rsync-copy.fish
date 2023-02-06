function rsync-copy --wraps='rsync -avz --progress -h' --description 'alias rsync-copy=rsync -avz --progress -h'
    rsync -avz --progress -h $argv
end
