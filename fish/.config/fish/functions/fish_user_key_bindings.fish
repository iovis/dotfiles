function fish_user_key_bindings
    # NOTE: Use `bind` to check your bindings in the terminal
    bind ctrl-n accept-autosuggestion
    bind ctrl-p nextd-or-forward-word

    # quick command pipes
    bind alt-g '__fish_custom_grep; commandline -f end-of-line'
    bind alt-j '__fish_custom_jq; commandline -f end-of-line'
    bind alt-n '__fish_custom_nvim; commandline -f end-of-line'
    bind alt-r '__fish_custom_rust_log; commandline -f end-of-line'
end
