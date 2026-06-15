default: init
install-mpv: install-thumbfast install-modernz

@list:
    just --list

init:
    git stash push
    git checkout master
    git pull
    git checkout -
    git rebase -
    git stash pop || true
    cd ~/co/skills/meraki-skills/ && git pull
    codex plugin marketplace upgrade

# Download and install the latest Thumbfast revision
install-thumbfast:
    #!/usr/bin/env bash
    set -euo pipefail

    mpv_dir="{{ justfile_directory() }}/mpv/.config/mpv"
    repository_api="https://api.github.com/repos/po5/thumbfast"
    temp_dir="$(mktemp -d)"
    trap 'rm -rf "$temp_dir"' EXIT

    commit="$(curl --fail --location --silent --show-error "$repository_api/commits/master")"
    revision="$(jq --exit-status --raw-output '.sha' <<<"$commit")"
    asset="$(curl --fail --location --silent --show-error "$repository_api/contents/thumbfast.lua?ref=$revision")"
    asset_url="$(jq --exit-status --raw-output '.download_url' <<<"$asset")"

    curl --fail --location --silent --show-error "$asset_url" --output "$temp_dir/thumbfast.lua"

    install -Dm644 "$temp_dir/thumbfast.lua" "$mpv_dir/scripts/thumbfast.lua"
    echo "Installed Thumbfast ${revision:0:7}"

# Download and install the latest ModernZ release
install-modernz:
    #!/usr/bin/env bash
    set -euo pipefail

    mpv_dir="{{ justfile_directory() }}/mpv/.config/mpv"
    release_api="https://api.github.com/repos/Samillion/ModernZ/releases/latest"
    temp_dir="$(mktemp -d)"
    trap 'rm -rf "$temp_dir"' EXIT

    release="$(curl --fail --location --silent --show-error "$release_api")"
    tag="$(jq --exit-status --raw-output '.tag_name' <<<"$release")"
    artifacts=(
        "modernz.lua:scripts/modernz.lua"
        "modernz-icons.ttf:fonts/modernz-icons.ttf"
    )
    for mapping in "${artifacts[@]}"; do
        asset_name="${mapping%%:*}"
        asset="$(jq --arg name "$asset_name" --compact-output --exit-status '.assets[] | select(.name == $name)' <<<"$release")"
        asset_url="$(jq --exit-status --raw-output '.browser_download_url' <<<"$asset")"

        curl --fail --location --silent --show-error "$asset_url" --output "$temp_dir/$asset_name"
    done

    for mapping in "${artifacts[@]}"; do
        asset_name="${mapping%%:*}"
        destination="${mapping#*:}"
        install -Dm644 "$temp_dir/$asset_name" "$mpv_dir/$destination"
    done

    echo "Installed ModernZ $tag"
