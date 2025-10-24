function rsy --wraps='rsync -aiv --progress -h --update --delete'
    r --update --delete $argv
end
