function libupdate
    upgrade_libraries

    rust_update

    fish_update_completions
    generate_completions

    mise self-update
    mise outdated

    npm -g outdated

    echo -e "\nOutdated gems"
    gemo

    echo -e "\nOutdated pips"
    pipo

    echo -e "\nDone!"
end
