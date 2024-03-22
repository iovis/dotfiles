function pcdn --wraps='podman compose down' --description 'alias pcdn=podman compose down'
    podman compose down $argv
end
