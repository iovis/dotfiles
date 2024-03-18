function fish_user_key_bindings
    bind \cn accept-autosuggestion
    bind \cp nextd-or-forward-word

    # grep command
    bind \eg '__fish_custom_grep; commandline -f end-of-line'
    bind \ej '__fish_custom_jq; commandline -f end-of-line'
end
