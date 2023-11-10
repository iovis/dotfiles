function nvimtest
    if set -q argv[1]
        set path $argv
    else
        set path 'spec/'
    end

    nvim --headless -c "PlenaryBustedDirectory $path"
end
