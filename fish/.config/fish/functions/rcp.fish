function rcp --wraps='rsync -av --progress -h'
    rsync -av --progress -h $argv
end
