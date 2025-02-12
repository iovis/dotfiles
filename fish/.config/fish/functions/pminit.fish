function pminit
    podman machine init --cpus 2 --memory 2048 --disk-size 40 && podman machine start
end
