-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  binds = {
    scroll_event_delay = 0, -- don't debounce mouse on binds
  },
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    -- kb_options = "compose:rctrl",  -- Special characters
    kb_options = "",
    kb_rules = "",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      natural_scroll = true,
    },
  },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
-- `hyprctl devices -j | jq '.mice[].name'`
hl.device({
  name = "-------am-infinity-8k-mouse",
  sensitivity = -0.5,
})
