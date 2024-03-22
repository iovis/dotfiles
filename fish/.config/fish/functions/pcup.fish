function pcup --wraps='podman compose up -d --remove-orphans'
    podman compose up -d --remove-orphans $argv
end
