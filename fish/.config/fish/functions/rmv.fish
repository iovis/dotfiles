function rmv --wraps='rsync -avz --progress -h --remove-source-files'
    rsync -avz --progress -h --remove-source-files $argv
end
