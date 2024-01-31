---Binds a command to run with an optional notification
---@param binding HammerspoonBinding
---@param command string
---@param notification? { success_message: string, error: boolean }
local bind_command = function(binding, command, notification)
  hs.hotkey.bind(binding[1], binding[2], function()
    print(command)
    notification = notification or {}

    hs.task
      .new(os.getenv("SHELL"), function(code, stdout, stderr)
        if notification.success_message and code == 0 then
          notify(notification.success_message)
        elseif code ~= 0 then
          print(code)
          print(stdout)
          print(stderr)

          if stderr:match("failed to connect to socket") then
            notify("Yabai is not running")
          end

          if notification.error then
            notify("Error running command: " .. command)
            hs.toggleConsole()
          end
        end
      end, { "-c", command })
      :start()
  end)
end

bind_command({ hyper, "r" }, "yabai --restart-service", {
  success_message = "Yabai reloaded",
  error = true,
})

------------
-- Window --
------------

---Focus window
bind_command(
  { ctrl_alt_cmd, "h" },
  "yabai -m window --focus west || begin; yabai -m display --focus prev || yabai -m display --focus last && yabai -m window --focus east; end"
)
bind_command({ ctrl_alt_cmd, "j" }, "yabai -m window --focus south")
bind_command({ ctrl_alt_cmd, "k" }, "yabai -m window --focus north")
bind_command(
  { ctrl_alt_cmd, "l" },
  "yabai -m window --focus east || begin; yabai -m display --focus prev || yabai -m display --focus last && yabai -m window --focus west; end"
)

---Swap managed window
bind_command({ hyper, "h" }, "yabai -m window --swap west")
bind_command({ hyper, "j" }, "yabai -m window --swap south")
bind_command({ hyper, "k" }, "yabai -m window --swap north")
bind_command({ hyper, "l" }, "yabai -m window --swap east")

---Warp window
bind_command({ hyper, "down" }, "yabai -m window --warp south")
bind_command({ hyper, "left" }, "yabai -m window --warp west")
bind_command({ hyper, "right" }, "yabai -m window --warp east")
bind_command({ hyper, "up" }, "yabai -m window --warp north")

---Resize windows (tmux like)
bind_command({ ctrl_alt_cmd, "left" }, "yabai -m window --resize left:-200:0 || yabai -m window --resize right:-200:0")
bind_command({ ctrl_alt_cmd, "down" }, "yabai -m window --resize bottom:0:200 || yabai -m window --resize top:0:200")
bind_command({ ctrl_alt_cmd, "up" }, "yabai -m window --resize top:0:-200 || yabai -m window --resize bottom:0:-200")
bind_command({ ctrl_alt_cmd, "right" }, "yabai -m window --resize right:200:0 || yabai -m window --resize left:200:0")

---Toggle window zoom
bind_command({ ctrl_alt_cmd, "m" }, "yabai -m window --toggle zoom-fullscreen")
bind_command({ ctrl_alt_cmd, "ñ" }, "yabai -m window --toggle zoom-parent")

----------------------
-- Floating Windows --
----------------------
-- NOTE: <rows>:<cols>:<start-x>:<start-y>:<width>:<height>
bind_command({ ctrl_alt_cmd, "y" }, "yabai_set_no_float")

---Sidebar
bind_command({ ctrl_alt, "o" }, "yabai_grid 2:5:-1:0:1:1")
bind_command({ ctrl_alt_cmd, "o" }, "yabai_grid 1:4:3:0:1:1")

---Halves
bind_command({ ctrl_alt, "left" }, "yabai_grid 1:2:0:0:1:1")
bind_command({ ctrl_alt, "right" }, "yabai_grid 1:2:1:0:1:1")

---Thirds
bind_command({ ctrl_alt, "y" }, "yabai_grid 1:4:0:0:3:1")
bind_command({ ctrl_alt, "p" }, "yabai_grid 1:4:1:0:3:1")

---Fourths
bind_command({ ctrl_alt, "u" }, "yabai_grid 2:2:0:0:1:1")
bind_command({ ctrl_alt, "i" }, "yabai_grid 2:2:1:0:1:1")
bind_command({ ctrl_alt, "j" }, "yabai_grid 2:2:0:1:1:1")
bind_command({ ctrl_alt, "k" }, "yabai_grid 2:2:1:1:1:1")

---Centered
bind_command({ ctrl_alt, "up" }, "yabai_grid 1:1:0:0:1:1")
bind_command({ ctrl_alt, "-" }, "yabai_grid 10:10:1:1:8:8")
bind_command({ ctrl_alt_cmd, "-" }, "yabai_grid 10:10:1:0:8:10")

--------------
-- Displays --
--------------
---Fast focus display
-- bind_command({ ctrl_alt_cmd, "space" }, "yabai -m display --focus prev || yabai -m display --focus last")

---send window to monitor and follow focus
bind_command({ hyper, "d" }, "yabai_send_to_other_display")

--------------
--  Spaces  --
--------------
-- NOTE: yabai would need scripting-addition for some actions
--    => Make Mission Control switch to space: ctrl+alt+cmd - 1
for i = 1, 2 do
  -- hyper - 1 : yabai -m window --space 1
  bind_command({ hyper, tostring(i) }, "yabai -m window --space " .. i)
end

-------------
-- Layouts --
-------------
bind_command({ hyper, "f" }, "yabai -m space --layout float")
bind_command({ hyper, "b" }, "yabai -m space --layout bsp")
bind_command({ ctrl_alt_cmd, "0" }, "yabai -m space --balance")

bind_command({ ctrl_alt_cmd, "4" }, "yabai_set_second_display")

bind_command({ hyper, "t" }, "yabai -m space --rotate 90")
bind_command({ hyper, "e" }, "yabai -m window --toggle split")
