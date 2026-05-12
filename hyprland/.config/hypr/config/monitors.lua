-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- hyprctl monitors
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "auto",
})

hl.monitor({
  output = "DP-1",
  mode = "2560x1440@360.00",
  position = "0x0",
  scale = "1",
})

-- Prevent hyprlock from crashing with no display
-- monitor=FALLBACK,1920x1080@60,auto,1
hl.monitor({
  output = "FALLBACK",
  mode = "1920x1080@60",
  position = "auto",
  scale = "1",
})
