function yabai_send_to_other_display
    yabai -m window --display prev || yabai -m window --display last
    yabai -m display --focus prev || yabai -m display --focus last
end
