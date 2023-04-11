function dcps --wraps='podman-compose ps' --description 'alias dcps=podman-compose ps'
    podman-compose ps $argv
end
