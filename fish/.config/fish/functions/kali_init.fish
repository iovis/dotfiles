function kali_init
    # NOTE: Docker images do not come with the "default" metapackage.
    # You will need to `apt update && apt -y install kali-linux-headless`
    echo "Run apt update && apt -y install kali-linux-headless"

    # Start a container for Kali
    podman run --tty --interactive --name kali kalilinux/kali-rolling

    # Here you should run `apt update && apt-y install kali-linux-headless` and so on

    # Save the new container state
    podman commit -p kali kali
end
