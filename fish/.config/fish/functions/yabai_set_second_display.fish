function yabai_set_second_display
    open -a Fantastical
    yabai -m window --display 2

    open -a Music
    yabai -m window --display 2
    yabai -m window --grid 10:3:0:10:1:1

    open -a Slack
    yabai -m window --display 2
    open -a Slack
    yabai -m window --swap east
    yabai -m space --balance
    yabai -m window --resize left:-250:0
end
