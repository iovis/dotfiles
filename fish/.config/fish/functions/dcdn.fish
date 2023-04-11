function dcdn --wraps='podman-compose down' --description 'alias dcdn=podman-compose down'
    podman-compose down $argv
end
