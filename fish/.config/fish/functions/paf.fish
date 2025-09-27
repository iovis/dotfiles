function paf --wraps='sudo pacman -S --needed'
    set pkg_names (
        pacman -Slq | fzf \
            --multi \
            --preview 'pacman -Sii {1}' \
            --preview-label 'alt-p: toggle description, alt-j/k: scroll, tab: multi-select, F11: maximize' \
            --preview-label-pos 'bottom' \
            --preview-window 'down:65%:wrap' \
            --bind 'alt-p:toggle-preview' \
            --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up' \
            --bind 'alt-k:preview-up,alt-j:preview-down' \
            --color 'pointer:green,marker:green' \
            --query "$argv"
    )

    if test -z "$pkg_names"
        return
    end

    pas $pkg_names
end
