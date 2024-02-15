function podman_reset --wraps='podman machine stop && podman machine rm podman-machine-default && podman machine init --cpus 2 --memory 2048 --disk-size 40 && podman machine start' --description 'alias podman_reset podman machine stop && podman machine rm podman-machine-default && podman machine init --cpus 2 --memory 2048 --disk-size 40 && podman machine start'
    podman machine stop
    podman machine rm -f podman-machine-default
    podman machine init --cpus 2 --memory 2048 --disk-size 40 && podman machine start $argv
end
