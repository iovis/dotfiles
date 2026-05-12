-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- `hyprctl clients -j | jq '.[].class'`
hl.window_rule({
  name = "fullscreen games",
  match = { class = "^(steam_app_\\d+)$" },
  border_size = 0,
  fullscreen = true,
  idle_inhibit = "fullscreen",
  immediate = true,
  no_anim = true,
  rounding = 0,
  suppress_event = "maximize",
  sync_fullscreen = true,
})

hl.window_rule({
  name = "Steam Big Picture fullscreen",
  match = { title = "Steam Big Picture Mode" },
  border_size = 0,
  fullscreen = true,
  idle_inhibit = "fullscreen",
  immediate = true,
  no_anim = true,
  rounding = 0,
  suppress_event = "maximize",
  sync_fullscreen = true,
})

hl.window_rule({
  name = "screensaver",
  match = { class = "widget\\.screensaver" },
  border_size = 0,
  fullscreen = true,
  idle_inhibit = "fullscreen",
  no_anim = true,
  rounding = 0,
})

-- Floating applications
hl.window_rule({
  name = "float-center",
  match = {
    -- TODO: turn into a table
    class = "^(1password|btrfs-assistant|mpv|org\\.gnome\\.(Calendar|Weather|baobab)|org\\.pulseaudio\\.pavucontrol|widget\\.kitty)$",
  },
  center = true,
  float = true,
  size = {
    "monitor_w * 0.5",
    "monitor_h * 0.5",
  },
})

hl.window_rule({
  name = "bluetui",
  match = { class = "widget\\.bluetui" },
  center = true,
  dim_around = true,
  float = true,
  pin = true,
  size = {
    "monitor_w * 0.35",
    "monitor_h * 0.40",
  },
})

hl.window_rule({
  name = "btop",
  match = { class = "widget\\.btop" },
  center = true,
  dim_around = true,
  float = true,
  size = {
    "monitor_w * 0.85",
    "monitor_h * 0.85",
  },
})

hl.window_rule({
  name = "calc",
  match = { class = "widget\\.calc" },
  center = true,
  dim_around = true,
  float = true,
  size = {
    "monitor_w * 0.33",
    "monitor_h * 0.33",
  },
})

hl.window_rule({
  name = "fn",
  match = { class = "widget\\.fn" },
  center = true,
  dim_around = true,
  float = true,
  pin = true,
  size = {
    "monitor_w * 0.5",
    "monitor_h * 0.5",
  },
})

hl.window_rule({
  name = "localsend",
  match = { class = "localsend" },
  center = true,
  float = true,
  pin = true,
  size = { 416, 640 },
})

hl.window_rule({
  name = "Picture-in-Picture",
  match = { title = "^(Picture-in-Picture|Picture in picture)$" },
  float = true,
  pin = true,
  focus_on_activate = false,
  no_initial_focus = true,
  size = { 640, 360 },
  move = {
    "monitor_w - window_w - 5",
    "monitor_h - window_h - 5",
  },
})

hl.window_rule({
  name = "powermenu",
  match = { class = "widget\\.powermenu" },
  center = true,
  dim_around = true,
  float = true,
  pin = true,
  size = { 400, 200 },
})

hl.window_rule({
  name = "satty",
  match = { class = "com\\.gabm\\.satty" },
  center = true,
  float = true,
  size = {
    "monitor_w * 0.85",
    "monitor_h * 0.85",
  },
})

hl.window_rule({
  name = "steam-friends",
  match = { title = "Friends List" },
  float = true,
  size = { 360, 640 },
  move = {
    "monitor_w - window_w - 5",
    "monitor_h - window_h - 5",
  },
})

hl.window_rule({
  name = "wiremix",
  match = { class = "widget\\.wiremix" },
  center = true,
  dim_around = true,
  float = true,
  pin = true,
  size = {
    "monitor_w * 0.5",
    "monitor_h * 0.5",
  },
})

-- Layer Rules (https://wiki.hypr.land/Configuring/Basics/Window-Rules/#layer-rules)
hl.layer_rule({
  name = "layer-blur",
  match = { namespace = "^(swayosd|vicinae|waybar|swaync-.*)$" },
  blur = true,
  ignore_alpha = 0.5,
})

-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- Workspace Selectors: https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/#workspace-selectors
-- w[tv1] -> workspace with 1 window
--   - t tiled-only
--   - v only count visible windows
-- f[1] -> fullscreen state of the workspace.
--   - -1 no fullscreen
--   -  0 fullscreen
--   -  1 maximized
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 5 + 2, gaps_in = 5 + 2 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 5, gaps_in = 5 })
hl.window_rule({
  match = {
    workspace = "w[tv1]",
    fullscreen_state_internal = 0,
    float = false,
  },
  border_size = 0,
})

-- Don't go to a random workspace when turning on the display
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
