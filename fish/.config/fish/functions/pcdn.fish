function pcdn --wraps='podman compose down'
    podman compose down $argv
end
