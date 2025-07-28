function libupdate
    upgrade_libraries

    log_step $(green rust) updates
    rust_update

    log_step Refreshing $(green fish) completions
    fish -c "fish_update_completions >/dev/null 2>&1" &
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

    log_step Done!
end
