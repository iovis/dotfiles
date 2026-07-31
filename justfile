default: init

@list:
    just --list

init:
    git stash push
    git pull
    git stash pop || true

# Download and install the latest Material OSC release.
install-material-osc:
    #!/usr/bin/env bash
    set -euo pipefail

    mpv_dir="{{ justfile_directory() }}/mpv/.config/mpv"
    release_api="https://api.github.com/repos/brahmkshatriya/material-osc/releases/latest"
    temp_dir="$(mktemp -d)"
    trap 'rm -rf "$temp_dir"' EXIT

    release="$(curl --fail --location --silent --show-error "$release_api")"
    tag="$(jq --exit-status --raw-output '.tag_name' <<<"$release")"
    asset="$(
        jq --compact-output --exit-status \
            '.assets[] | select(.name == "material-osc.zip")' \
            <<<"$release"
    )"
    asset_url="$(
        jq --exit-status --raw-output '.browser_download_url' <<<"$asset"
    )"
    asset_digest="$(jq --exit-status --raw-output '.digest' <<<"$asset")"
    if [[ "$asset_digest" != sha256:* ]]; then
        echo "Release asset does not provide a SHA-256 digest" >&2
        exit 1
    fi

    archive="$temp_dir/material-osc.zip"
    curl --fail --location --silent --show-error "$asset_url" --output "$archive"
    printf '%s  %s\n' "${asset_digest#sha256:}" "$archive" |
        sha256sum --check --status

    extract_dir="$temp_dir/extract"
    unzip -q "$archive" -d "$extract_dir"
    artifacts=(
        "scripts/material-osc.lua"
        "fonts/material-osc_icons.otf"
        "fonts/material-osc_google_sans_flex.ttf"
    )
    for artifact in "${artifacts[@]}"; do
        if [[ ! -f "$extract_dir/$artifact" ]]; then
            echo "Release archive is missing $artifact" >&2
            exit 1
        fi
    done
    for artifact in "${artifacts[@]}"; do
        install -Dm644 "$extract_dir/$artifact" "$mpv_dir/$artifact"
    done

    echo "Installed Material OSC $tag"
