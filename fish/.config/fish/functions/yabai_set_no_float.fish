function yabai_set_no_float
    set -l window_settings (yabai -m query --windows --window)

    if test (echo $window_settings | jq '."is-floating"') = true
        yabai -m window --toggle float
        return
    end

    if test (echo $window_settings | jq '."has-fullscreen-zoom"') = true
        yabai -m window --toggle zoom-fullscreen
        return
    end

    if test (echo $window_settings | jq '."has-parent-zoom"') = true
        yabai -m window --toggle zoom-parent
        return
    end
end
