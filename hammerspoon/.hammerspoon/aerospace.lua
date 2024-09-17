local u = require("utils")

u.bind.cmd({ hyper, "r" }, "aerospace reload-config", {
  success_message = "Aerospace reloaded",
  error = true,
})

-------------
-- Layouts --
-------------
---See: https://nikitabobko.github.io/AeroSpace/commands#layout
u.bind.cmd({ ctrl_alt_cmd, "," }, "aerospace layout accordion horizontal")
u.bind.cmd({ ctrl_alt_cmd, "/" }, "aerospace layout tiles horizontal vertical")
u.bind.cmd({ ctrl_alt_cmd, "0" }, "aerospace flatten-workspace-tree")
u.bind.cmd({ ctrl_alt_cmd, "y" }, "aerospace layout floating tiling")

----------------
-- Workspaces --
----------------
---See: https://nikitabobko.github.io/AeroSpace/commands#workspace
u.bind.cmd({ ctrl_shift, "delete" }, "aerospace workspace-back-and-forth")

for i = 1, 5 do
  u.bind.cmd({ ctrl_alt_cmd, tostring(i) }, ("aerospace workspace %d"):format(i))
  u.bind.cmd({ hyper, tostring(i) }, ("aerospace move-node-to-workspace %d && aerospace workspace %d"):format(i, i))
end

------------
-- Window --
------------
---Focus window
---See: https://nikitabobko.github.io/AeroSpace/commands#focus
u.bind.cmd({ ctrl_alt_cmd, "h" }, "aerospace focus left --boundaries all-monitors-outer-frame")
u.bind.cmd({ ctrl_alt_cmd, "j" }, "aerospace focus down")
u.bind.cmd({ ctrl_alt_cmd, "k" }, "aerospace focus up")
u.bind.cmd({ ctrl_alt_cmd, "l" }, "aerospace focus right --boundaries all-monitors-outer-frame")

---Move window
---See: https://nikitabobko.github.io/AeroSpace/commands#move
u.bind.cmd({ hyper, "h" }, "aerospace move left")
u.bind.cmd({ hyper, "j" }, "aerospace move down")
u.bind.cmd({ hyper, "k" }, "aerospace move up")
u.bind.cmd({ hyper, "l" }, "aerospace move right")

---Join window
---See: https://nikitabobko.github.io/AeroSpace/commands#join-with
u.bind.cmd({ ctrl_alt_cmd, "left" }, "aerospace join-with left")
u.bind.cmd({ ctrl_alt_cmd, "down" }, "aerospace join-with down")
u.bind.cmd({ ctrl_alt_cmd, "up" }, "aerospace join-with up")
u.bind.cmd({ ctrl_alt_cmd, "right" }, "aerospace join-with right")

---Resize windows
---See: https://nikitabobko.github.io/AeroSpace/commands#resize
u.bind.cmd({ ctrl_shift, "left" }, "aerospace resize width -400")
u.bind.cmd({ ctrl_shift, "down" }, "aerospace resize width -200")
u.bind.cmd({ ctrl_shift, "up" }, "aerospace resize width +200")
u.bind.cmd({ ctrl_shift, "right" }, "aerospace resize width +400")

---Toggle window zoom
u.bind.cmd({ ctrl_alt_cmd, "m" }, "aerospace fullscreen")

----------------------
-- Floating Windows --
----------------------
---Use native window tiling
---@param binding HammerspoonBinding
---@param os_shortcut HammerspoonBinding
local float_layout = function(binding, os_shortcut)
  hs.hotkey.bind(binding[1], binding[2], function()
    u.task("aerospace layout floating || true"):start()
    hs.eventtap.keyStroke(os_shortcut[1], os_shortcut[2])
  end)
end

---Halves (TODO: not working with fn+ctrl+arrow)
float_layout({ ctrl_shift, "h" }, { hyper, "left" })
float_layout({ ctrl_shift, "l" }, { hyper, "right" })

---Fourths
float_layout({ ctrl_shift, "m" }, { hyper, "u" })
float_layout({ ctrl_shift, "," }, { hyper, "i" })
float_layout({ ctrl_shift, "." }, { hyper, "o" })
float_layout({ ctrl_shift, "/" }, { hyper, "p" })

---Centered
float_layout({ ctrl_shift, "k" }, { fn_ctrl, "f" })
float_layout({ ctrl_shift, "j" }, { fn_ctrl, "c" })

--------------
-- Displays --
--------------
---send window to monitor and follow focus
u.bind.cmd(
  { ctrl_alt_cmd, "tab" },
  "aerospace move-node-to-monitor --wrap-around next && aerospace focus-monitor --wrap-around next"
)
