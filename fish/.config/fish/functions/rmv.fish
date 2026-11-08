function rmv --wraps='rsync -aih --info=progress2 --checksum --remove-source-files'
    r --checksum --remove-source-files $argv
end
