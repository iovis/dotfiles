function pcstop --wraps='podman-compose stop' --description 'alias pcstop=podman-compose stop'
    podman-compose stop $argv
end
