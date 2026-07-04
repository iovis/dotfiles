function mpk --wraps=mpv
    mpv --vo=kitty --vo-kitty-use-shm=yes --vo-kitty-auto-multiplexer-passthrough=yes $argv
end
