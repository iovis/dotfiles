-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- hyprctl monitors
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "auto",
})

-- Prevent hyprlock from crashing with no display
-- monitor=FALLBACK,1920x1080@60,auto,1
hl.monitor({
  output = "FALLBACK",
  mode = "1920x1080@60",
  position = "auto",
  scale = "1",
})

hl.monitor({
  output = "DP-1",
  mode = "2560x1440@360.00",
  position = "0x0",
  scale = "1",
  vrr = 3, -- fullscreen games and video only
})

-- Don't go to a random workspace when turning on the display
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })

hl.monitor({
  output = "HDMI-A-2",
  mode = "2560x1440@360.00",
  position = "0x0",
  scale = "1",
  vrr = 3,
})

hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-2", default = true })
