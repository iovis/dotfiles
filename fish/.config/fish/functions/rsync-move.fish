function rsync-move --wraps='rsync -avz --progress -h --remove-source-files' --description 'alias rsync-move=rsync -avz --progress -h --remove-source-files'
    rsync -avz --progress -h --remove-source-files $argv
end
