function r --wraps='rsync -aih --info=progress2'
    command rsync -aih --info=progress2 $argv
end
