function r --wraps='rsync -aiv --progress -h'
    rsync -aiv --progress -h $argv
end
