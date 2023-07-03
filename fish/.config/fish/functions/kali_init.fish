function kali_init
    # NOTE: Docker images do not come with the "default" metapackage.
    # You will need to `apt update && apt -y install kali-linux-headless`
    echo "Run apt update && apt -y install kali-linux-headless"
    podman run --tty --interactive --name kali kalilinux/kali-rolling
end
