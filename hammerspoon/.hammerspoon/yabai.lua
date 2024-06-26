local u = require("utils")

u.bind.cmd({ hyper, "r" }, "yabai --restart-service", {
  success_message = "Yabai reloaded",
  error = true,
})

------------
-- Window --
------------

---Focus window
u.bind.cmd(
  { ctrl_alt_cmd, "h" },
  "yabai -m window --focus west || begin; yabai -m display --focus prev || yabai -m display --focus last && yabai -m window --focus east; end"
)
u.bind.cmd({ ctrl_alt_cmd, "j" }, "yabai -m window --focus south")
u.bind.cmd({ ctrl_alt_cmd, "k" }, "yabai -m window --focus north")
u.bind.cmd(
  { ctrl_alt_cmd, "l" },
  "yabai -m window --focus east || begin; yabai -m display --focus prev || yabai -m display --focus last && yabai -m window --focus west; end"
)

---Swap managed window
u.bind.cmd({ hyper, "h" }, "yabai -m window --swap west")
u.bind.cmd({ hyper, "j" }, "yabai -m window --swap south")
u.bind.cmd({ hyper, "k" }, "yabai -m window --swap north")
u.bind.cmd({ hyper, "l" }, "yabai -m window --swap east")

---Warp window
u.bind.cmd({ hyper, "down" }, "yabai -m window --warp south")
u.bind.cmd({ hyper, "left" }, "yabai -m window --warp west")
u.bind.cmd({ hyper, "right" }, "yabai -m window --warp east")
u.bind.cmd({ hyper, "up" }, "yabai -m window --warp north")

---Resize windows (tmux like)
u.bind.cmd({ ctrl_alt_cmd, "left" }, "yabai -m window --resize left:-200:0 || yabai -m window --resize right:-200:0")
u.bind.cmd({ ctrl_alt_cmd, "down" }, "yabai -m window --resize bottom:0:200 || yabai -m window --resize top:0:200")
u.bind.cmd({ ctrl_alt_cmd, "up" }, "yabai -m window --resize top:0:-200 || yabai -m window --resize bottom:0:-200")
u.bind.cmd({ ctrl_alt_cmd, "right" }, "yabai -m window --resize right:200:0 || yabai -m window --resize left:200:0")

---Toggle window zoom
u.bind.cmd({ ctrl_alt_cmd, "m" }, "yabai -m window --toggle zoom-fullscreen")
u.bind.cmd({ ctrl_alt_cmd, ";" }, "yabai -m window --toggle zoom-parent")

----------------------
-- Floating Windows --
----------------------
-- NOTE: <rows>:<cols>:<start-x>:<start-y>:<width>:<height>
u.bind.cmd({ ctrl_alt_cmd, "y" }, "yabai_set_no_float")

---Sidebar
u.bind.cmd({ ctrl_alt, "o" }, "yabai_grid 2:5:-1:0:1:1")
u.bind.cmd({ ctrl_alt_cmd, "o" }, "yabai_grid 1:4:3:0:1:1")

u.bind.cmd({ ctrl_alt, "q" }, "yabai_grid 2:5:0:0:1:1")
u.bind.cmd({ ctrl_alt_cmd, "q" }, "yabai_grid 1:4:0:0:1:1")

---Halves
u.bind.cmd({ ctrl_alt, "left" }, "yabai_grid 1:2:0:0:1:1")
u.bind.cmd({ ctrl_alt, "right" }, "yabai_grid 1:2:1:0:1:1")

---Thirds
u.bind.cmd({ ctrl_alt, "y" }, "yabai_grid 1:4:0:0:3:1")
u.bind.cmd({ ctrl_alt, "p" }, "yabai_grid 1:4:1:0:3:1")

---Fourths
u.bind.cmd({ ctrl_alt, "u" }, "yabai_grid 2:2:0:0:1:1")
u.bind.cmd({ ctrl_alt, "i" }, "yabai_grid 2:2:1:0:1:1")
u.bind.cmd({ ctrl_alt, "j" }, "yabai_grid 2:2:0:1:1:1")
u.bind.cmd({ ctrl_alt, "k" }, "yabai_grid 2:2:1:1:1:1")

---Centered
u.bind.cmd({ ctrl_alt, "/" }, "yabai_grid 20:20:3:2:14:15")
u.bind.cmd({ ctrl_alt, "up" }, "yabai_grid 1:1:0:0:1:1")
u.bind.cmd({ ctrl_alt_cmd, "/" }, "yabai_grid 10:10:1:0:8:10")

--------------
-- Displays --
--------------
---send window to monitor and follow focus
u.bind.cmd({ ctrl_alt_cmd, "space" }, "yabai_send_to_other_display")

--------------
--  Spaces  --
--------------
-- NOTE: yabai would need scripting-addition for some actions
--    => Make Mission Control switch to space: ctrl+alt+cmd - 1
for i = 1, 2 do
  -- hyper - 1 : yabai -m window --space 1
  u.bind.cmd({ hyper, tostring(i) }, "yabai -m window --space " .. i)
end

-------------
-- Layouts --
-------------
u.bind.cmd({ hyper, "f" }, "yabai -m space --layout float")
u.bind.cmd({ hyper, "b" }, "yabai -m space --layout bsp")
u.bind.cmd({ ctrl_alt_cmd, "0" }, "yabai -m space --balance")

u.bind.cmd({ ctrl_alt_cmd, "p" }, "yabai_set_second_display")

u.bind.cmd({ hyper, "t" }, "yabai -m space --rotate 90")
u.bind.cmd({ hyper, "e" }, "yabai -m window --toggle split")
