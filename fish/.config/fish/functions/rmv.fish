function rmv --wraps='rsync -av --progress -h --remove-source-files'
    rsync -av --progress -h --remove-source-files $argv
end
