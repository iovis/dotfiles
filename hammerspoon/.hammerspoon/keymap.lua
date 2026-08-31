local u = require("utils")
local layouts = require("terminal_popups").layouts

---- System
hs.hotkey.bind(hyper, "c", hs.toggleConsole)
hs.hotkey.bind(ctrl_alt_cmd, "r", hs.reload)
hs.hotkey.bind(ctrl_alt_cmd, "q", nil, function()
  hs.eventtap.keyStroke({ "cmd" }, "q", 0)
end)

u.bind.cmd({ hyper, "r" }, "aerospace reload-config --warnings-as-errors", {
  success_message = "Aerospace reloaded",
  error = true,
})

---- Applications
u.bind.app({ ctrl_alt_cmd, "a" }, "zoom.us")
u.bind.app({ ctrl_alt_cmd, "s" }, "Slack")
u.bind.app({ ctrl_alt_cmd, "d" }, "Ghostty")
u.bind.app({ ctrl_alt_cmd, "f" }, "Arc")
u.bind.app({ hyper, "f" }, "Safari")
u.bind.app({ ctrl_alt_cmd, "g" }, "Google Chrome Canary")

u.bind.app({ ctrl_alt_cmd, "w" }, "Messages")

u.bind.app({ ctrl_alt_cmd, "x" }, "Music")
u.bind.app({ ctrl_alt_cmd, "c" }, "Calendar")

u.bind.app({ hyper, "i" }, "iPhone Mirroring")
u.bind.app({ ctrl_alt_cmd, "i" }, "IINA")
u.bind.app({ hyper, "o" }, "Obsidian")
u.bind.app({ ctrl_alt_cmd, "p" }, "1Password")

---- Terminal popups
u.bind.popup({ ctrl_alt_cmd, "e" }, "aerc-terminal", {
  layout = layouts.centered_66,
  launch_or_focus = true,
  title = "popup:aerc",
})
u.bind.popup({ ctrl_alt_cmd, "t" }, "htop", { layout = layouts.centered_66 })
u.bind.popup({ hyper, "y" }, "yazi", { layout = layouts.centered_50 })
u.bind.popup({ ctrl_alt_cmd, "u" }, "calc", { layout = layouts.centered_400x200 })
u.bind.popup({ ctrl_alt_cmd, "o" }, "fn", { layout = layouts.centered_50 })

---- Floating windows
-- Halves (TODO: not working with fn+ctrl+arrow, so I had to remap at OS level)
u.bind.float_layout({ ctrl_shift, "h" }, { hyper, "left" })
u.bind.float_layout({ ctrl_shift, "l" }, { hyper, "right" })

-- Fourths (no default mapping, had to give it one at OS level)
u.bind.float_layout({ ctrl_shift, "u" }, { hyper, "t" })
u.bind.float_layout({ ctrl_shift, "o" }, { hyper, "w" })
u.bind.float_layout({ ctrl_shift, "m" }, { hyper, "z" })
u.bind.float_layout({ ctrl_shift, "." }, { hyper, "x" })

-- Centered
u.bind.float_layout({ ctrl_shift, "k" }, { fn_ctrl, "f" })
u.bind.float_layout({ ctrl_shift, "j" }, { fn_ctrl, "c" })
u.bind.float_layout({ ctrl_shift, ";" }, { fn_ctrl, "r" })

---- Debugging
if false then
  print(hs.inspect(hs.keycodes.map))
  local tap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    print(hs.inspect(event:getRawEventData()))
  end)
  tap:start()
end
