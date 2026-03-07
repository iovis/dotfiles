function mpvd --wraps=mpv
    if not set -q argv[1]
        set argv .
    end

    mpv --autocreate-playlist=filter --directory-mode=recursive $argv
end
