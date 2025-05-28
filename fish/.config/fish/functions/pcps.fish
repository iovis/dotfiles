function pcps --wraps='podman compose ps'
    podman compose ps $argv
end
