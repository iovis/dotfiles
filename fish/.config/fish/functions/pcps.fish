function pcps --wraps='podman-compose ps' --description 'alias pcps=podman-compose ps'
    podman-compose ps $argv
end
