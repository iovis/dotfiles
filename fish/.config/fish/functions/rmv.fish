function rmv --wraps='rsync -aiv --progress -h --remove-source-files'
    r --remove-source-files $argv
end
