function pcstop --wraps='podman-compose stop' --description 'alias dcstop=podman-compose stop'
    podman-compose stop $argv
end
