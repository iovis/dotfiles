function upgrade_libraries
    brew update
    brew upgrade
    brew autoremove
    brewdump
end
