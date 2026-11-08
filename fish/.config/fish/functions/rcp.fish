function rcp --wraps='rsync -aih --info=progress2'
    r $argv
end
