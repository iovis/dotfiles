function rcp --wraps='rsync -avz --progress -h'
    rsync -avz --progress -h $argv
end
