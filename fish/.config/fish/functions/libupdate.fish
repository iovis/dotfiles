function libupdate
    upgrade_libraries

    log_step $(green rust) updates
    rust_update

    log_step Refreshing $(green fish) completions
    fish_update_completions
    generate_completions

    log_step $(green mise) self-update
    mise self-update --yes

    log_step $(green mise) outdated --bump
    mise outdated --bump

    log_step $(green mise) outdated
    mise outdated

    log_step $(green npm) outdated
    npm -g outdated

    log_step $(green gem) outdated
    gemo

    log_step $(green pip) outdated
    pipo

    log_step Done!
end
