function pcstop --wraps='podman compose stop'
    podman compose stop $argv
end
