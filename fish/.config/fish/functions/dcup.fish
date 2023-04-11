function dcup --wraps='podman machine start; podman-compose up -d --remove-orphans' --description 'alias dcup podman machine start; podman-compose up -d --remove-orphans'
    podman machine start; podman-compose up -d --remove-orphans $argv
end
