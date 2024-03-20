function fish_user_key_bindings
    # NOTE: Use `bind` to check your bindings in the terminal
    bind \cn accept-autosuggestion
    bind \cp nextd-or-forward-word

    # quick command pipes
    bind \eg '__fish_custom_grep; commandline -f end-of-line'
    bind \ej '__fish_custom_jq; commandline -f end-of-line'
end
