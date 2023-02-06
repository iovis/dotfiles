function yabai_set_float
    if test (yabai -m query --windows --window | jq '."is-floating"') != true
        yabai -m window --toggle float
    end
end
