function yabai_set_second_display
    # Move Calendar to display
    open -a "Microsoft Outlook"
    yabai_set_no_float
    yabai -m window --display 2

    # Move Music to display
    open -a Music
    yabai_set_float
    yabai -m window --display 2
    yabai -m window --grid 10:3:0:10:1:1

    # Move Slack to display
    open -a Slack
    yabai_set_no_float
    yabai -m window --display 2

    # Order windows
    open -a Slack
    yabai -m window --swap east
    yabai -m space --balance
    yabai -m window --resize left:-250:0
end
