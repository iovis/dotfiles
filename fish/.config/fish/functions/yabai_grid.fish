function yabai_grid
    yabai_set_float

    # set old_frame (yabai -m query --windows --window | jq '.frame')

    yabai -m window --grid $argv[1]
    # sleep 0.1 # seems like there's a race condition
    # set current_frame (yabai -m query --windows --window | jq '.frame')
    #
    # # if not changed: Cycle display
    # if test "$old_frame" = "$current_frame"
    #     yabai_send_to_other_display
    #     yabai -m window --grid $argv[1]
    # end
end
