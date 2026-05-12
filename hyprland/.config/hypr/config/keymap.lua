-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- NOTE: use `wev` to see key names

---- Power management
local logout = "loginctl lock-session"
local powermenu = "hyprclose class:widget.powermenu || kitty --class=widget.powermenu -e powermenu"
local screensaver = "kitty --class=widget.screensaver -o background_opacity=1 -o background=black -e cmatrix -bsk"
hl.bind("CTRL + SUPER + Q", hl.dsp.exec_cmd(logout))
hl.bind("SUPER + Backspace", hl.dsp.exec_cmd(screensaver))
hl.bind("CTRL + SUPER + Backspace", hl.dsp.exec_cmd(powermenu))

---- Applications
-- `hyprctl clients -j | jq '.[].class'`
hl.bind("SUPER + W", hl.dsp.exec_cmd("pkill gnome-weather || uwsm app -- gnome-weather"))
hl.bind("CTRL + SUPER + W", hl.dsp.exec_cmd("pkill waybar || uwsm app -- waybar"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("hyprfocus class:org.gnome.Nautilus || uwsm app -- nautilus"))
hl.bind("CTRL + SUPER + E", hl.dsp.exec_cmd("uwsm app -- nautilus --new-window"))
hl.bind("CTRL + SUPER + R", hl.dsp.exec_cmd("screenrecord"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("hyprclose class:widget.btop || kitty --class=widget.btop -e btop"))
hl.bind("CTRL + SUPER + T", hl.dsp.exec_cmd("hyprclose class:widget.btop || kitty --class=widget.btop -e htop"))

hl.bind("SUPER + A", hl.dsp.exec_cmd("hyprclose class:widget.wiremix || kitty --class=widget.wiremix -e wiremix"))
hl.bind("SHIFT + SUPER + A", hl.dsp.exec_cmd("hyprfocus class:org.pulseaudio.pavucontrol || uwsm app -- pavucontrol"))
hl.bind("SUPER + S", hl.dsp.exec_cmd("hyprfocus class:steam || STEAM_RUNTIME=1 steam -no-cef-sandbox -cef-force-glx"))
hl.bind("CTRL + SUPER + S", hl.dsp.exec_cmd("XDG_CURRENT_DESKTOP=GNOME gnome-control-center"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("hyprfocus class:com.mitchellh.ghostty || uwsm app -- ghostty"))
hl.bind("CTRL + SUPER + D", hl.dsp.exec_cmd("uwsm app -- ghostty"))
hl.bind("SUPER + F", hl.dsp.exec_cmd("hyprfocus class:zen || uwsm app -- zen-browser"))
hl.bind("CTRL + SUPER + F", hl.dsp.exec_cmd("uwsm app -- zen-browser --private-window"))
hl.bind("SUPER + G", hl.dsp.exec_cmd("hyprfocus class:chromium || uwsm app -- chromium"))
hl.bind("CTRL + SUPER + G", hl.dsp.exec_cmd("uwsm app -- chromium --incognito"))

hl.bind("SUPER + X", hl.dsp.exec_cmd("hyprfocus class:localsend || GTK_THEME=Adwaita:dark uwsm app -- localsend"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("hyprclose class:widget.fn || kitty --class=widget.fn -e opencode ~/code/"))
hl.bind("CTRL + SUPER + C", hl.dsp.exec_cmd("hyprclose class:widget.calc || kitty --class=widget.calc -e calc"))
hl.bind("SHIFT + SUPER + C", hl.dsp.exec_cmd("hyprfocus class:org.gnome.Calendar || uwsm app -- gnome-calendar"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("vicinae_toggle deeplink vicinae://launch/@Gelei/store.vicinae.bluetooth/devices"))
hl.bind(
  "CTRL + SUPER + B",
  hl.dsp.exec_cmd("hyprclose class:widget.bluetui || kitty --class=widget.bluetui -e bluetui")
)
hl.bind("SUPER + V", hl.dsp.exec_cmd("vicinae_toggle deeplink vicinae://launch/clipboard/history"))
hl.bind("CTRL + SUPER + V", hl.dsp.exec_cmd("hyprclose 'class:Mullvad VPN' || mullvad-vpn"))

hl.bind("CTRL + SUPER + Y", hl.dsp.exec_cmd("hyprclose class:widget.btop || kitty --class=widget.btop -e yazi"))
hl.bind("SUPER + I", hl.dsp.exec_cmd("screenshot output"))
hl.bind("CTRL + SUPER + I", hl.dsp.exec_cmd("screenshot region"))
hl.bind("SHIFT + SUPER + I", hl.dsp.exec_cmd("screenshot window"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("hyprclose class:widget.fn || kitty --class=widget.fn -e fn"))
hl.bind("CTRL + SUPER + O", hl.dsp.exec_cmd("hyprfocus class:obsidian || uwsm app -- obsidian"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("hyprfocus class:1Password || uwsm app -- 1password"))
hl.bind("SHIFT + SUPER + P", hl.dsp.exec_cmd("hyprpicker --autocopy"))

hl.bind("SUPER + Space", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind("CTRL + SHIFT + Space", hl.dsp.exec_cmd("vicinae_toggle deeplink vicinae://launch/core/search-emojis"))

hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind("CTRL + SUPER + N", hl.dsp.exec_cmd("swaync-client -C"))
hl.bind("SHIFT + SUPER + N", hl.dsp.exec_cmd("swaync-client -d"))

hl.bind("Print", hl.dsp.exec_cmd("screenshot output"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd("screenshot window"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("screenshot region"))

---- Window management
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("CTRL + SUPER + X", hl.dsp.window.kill())
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind("CTRL + SUPER + M", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind("SUPER + R", hl.dsp.layout("togglesplit"))

-- alt tab
hl.bind("ALT + Tab", function()
  hl.dispatch(hl.dsp.window.cycle_next({ next = true }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end, { repeating = true })

hl.bind("SHIFT + ALT + Tab", function()
  hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end, { repeating = true })

-- window resizing
hl.bind("SUPER + Right", hl.dsp.window.resize({ x = 300, y = 0, relative = true }))
hl.bind("SUPER + Left", hl.dsp.window.resize({ x = -300, y = 0, relative = true }))
hl.bind("SUPER + Down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
hl.bind("SUPER + Up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))

-- move focus with vim keys
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))

-- swap windows
hl.bind("SHIFT + SUPER + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind("SHIFT + SUPER + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind("SHIFT + SUPER + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SHIFT + SUPER + L", hl.dsp.window.swap({ direction = "right" }))

-- move/resize windows with mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- TODO: temporary till there's a keep_aspect_ratio dispatcher
local keep_aspect_resize_window = nil
hl.bind("CTRL + SUPER + mouse:273", function()
  keep_aspect_resize_window = hl.get_active_window()
  if keep_aspect_resize_window then
    hl.dispatch(hl.dsp.window.set_prop({
      window = keep_aspect_resize_window,
      prop = "keep_aspect_ratio",
      value = "1",
    }))
  end
  hl.dispatch(hl.dsp.window.resize())
end, { mouse = true })

hl.bind("CTRL + SUPER + mouse:273", function()
  if not keep_aspect_resize_window then
    return
  end

  hl.dispatch(hl.dsp.window.set_prop({
    window = keep_aspect_resize_window,
    prop = "keep_aspect_ratio",
    value = "unset",
  }))
  keep_aspect_resize_window = nil
end, { release = true })

-- Floating windows
hl.bind("SUPER + Y", hl.dsp.window.float({ action = "toggle" }))

-- move window
hl.bind("CTRL + SUPER + Down", function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "down" }))
end)

hl.bind("CTRL + SUPER + Left", function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "left" }))
end)

hl.bind("CTRL + SUPER + Right", function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "right" }))
end)

hl.bind("CTRL + SUPER + Up", function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "up" }))
end)

-- centerwindow (floating only)
hl.bind("SUPER + comma", function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.center())
end)

hl.bind("CTRL + SUPER + comma", function()
  local monitor = assert(hl.get_active_monitor())
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.resize({ x = monitor.width * 0.75, y = monitor.height * 0.75 }))
  hl.dispatch(hl.dsp.window.center())
end)

-- pin floating window to all spaces
hl.bind("CTRL + SUPER + P", function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.pin())
end)

---- Workspaces
hl.bind("CTRL + SUPER + H", hl.dsp.focus({ workspace = "-1" }))
hl.bind("CTRL + SUPER + J", hl.dsp.window.move({ workspace = "-1" }))
hl.bind("CTRL + SUPER + K", hl.dsp.window.move({ workspace = "+1" }))
hl.bind("CTRL + SUPER + L", hl.dsp.focus({ workspace = "+1" }))

hl.bind("CTRL + SUPER + Space", hl.dsp.focus({ workspace = "previous" }))

for i = 1, 9 do
  hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind("SHIFT + SUPER + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + Tab", hl.dsp.window.move({ workspace = "empty" }))
hl.bind("SUPER + Return", function() -- TODO: till we get workspacemovesilent
  hl.dispatch(hl.dsp.window.move({ workspace = "empty" }))
  hl.dispatch(hl.dsp.focus({ workspace = "previous" }))
end)

-- mouse quick switch
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

---- Media keys
-- Only display the OSD on the currently focused monitor
local osdclient = [[swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" ]]

-- Laptop multimedia keys for volume and LCD brightness (with OSD)
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd(osdclient .. "--output-volume raise"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd(osdclient .. "--output-volume lower"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd(osdclient .. "--output-volume mute-toggle"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd(osdclient .. "--input-volume mute-toggle"),
  { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(osdclient .. "--brightness raise"), {
  locked = true,
  repeating = true,
})
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(osdclient .. "--brightness lower"), {
  locked = true,
  repeating = true,
})

-- Precise 1% multimedia adjustments
hl.bind("CTRL + XF86AudioRaiseVolume", hl.dsp.exec_cmd(osdclient .. "--output-volume +1"), {
  locked = true,
  repeating = true,
})
hl.bind("CTRL + XF86AudioLowerVolume", hl.dsp.exec_cmd(osdclient .. "--output-volume -1"), {
  locked = true,
  repeating = true,
})
hl.bind("CTRL + XF86MonBrightnessUp", hl.dsp.exec_cmd(osdclient .. "--brightness +1"), {
  locked = true,
  repeating = true,
})
hl.bind("CTRL + XF86MonBrightnessDown", hl.dsp.exec_cmd(osdclient .. "--brightness -1"), {
  locked = true,
  repeating = true,
})

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(osdclient .. "--playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(osdclient .. "--playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(osdclient .. "--playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(osdclient .. "--playerctl previous"), { locked = true })
