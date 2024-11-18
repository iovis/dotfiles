function libupdate
    upgrade_libraries

    log_step Rust updates
    rust_update

    log_step Refreshing fish completions
    fish_update_completions
    generate_completions

    log_step Mise self-update
    mise self-update --yes

    log_step Mise outdated --bump
    mise outdated --bump

    log_step Mise outdated
    mise outdated

    log_step Npm outdated
    npm -g outdated

    log_step Gem outdated
    gemo

    log_step Pip outdated
    pipo

    log_step Done!
end
