-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- NOTE: use `wev` to see key names

local function g(key)
  return ("SUPER + %s"):format(key)
end

local function c(key)
  return ("CTRL + %s"):format(key)
end

local function s(key)
  return ("SHIFT + %s"):format(key)
end

local function a(key)
  return ("ALT + %s"):format(key)
end

---- Power management
local logout = "loginctl terminate user david"
local powermenu = "hyprclose class:widget.powermenu || kitty --class=widget.powermenu -e powermenu"
local screensaver = "kitty --class=widget.screensaver -o background_opacity=1 -o background=black -e cmatrix -bsk"
hl.bind(c(g("q")), hl.dsp.exec_cmd(logout))
hl.bind(g("backspace"), hl.dsp.exec_cmd(screensaver))
hl.bind(c(g("backspace")), hl.dsp.exec_cmd(powermenu))

---- Applications
-- `hyprctl clients -j | jq '.[].class'`
hl.bind(g("w"), hl.dsp.exec_cmd("pkill gnome-weather || uwsm app -- gnome-weather"))
hl.bind(c(g("w")), hl.dsp.exec_cmd("pkill waybar || uwsm app -- waybar"))
hl.bind(g("e"), hl.dsp.exec_cmd("hyprfocus class:org.gnome.Nautilus || uwsm app -- nautilus"))
hl.bind(c(g("e")), hl.dsp.exec_cmd("uwsm app -- nautilus --new-window"))
hl.bind(c(g("r")), hl.dsp.exec_cmd("screenrecord"))
hl.bind(g("t"), hl.dsp.exec_cmd("hyprclose class:widget.btop || kitty --class=widget.btop -e btop"))
hl.bind(c(g("t")), hl.dsp.exec_cmd("hyprclose class:widget.btop || kitty --class=widget.btop -e htop"))

hl.bind(g("a"), hl.dsp.exec_cmd("hyprclose class:widget.wiremix || kitty --class=widget.wiremix -e wiremix"))
hl.bind(s(g("a")), hl.dsp.exec_cmd("hyprfocus class:org.pulseaudio.pavucontrol || uwsm app -- pavucontrol"))
hl.bind(g("s"), hl.dsp.exec_cmd("hyprfocus class:steam || STEAM_RUNTIME=1 steam -no-cef-sandbox -cef-force-glx"))
hl.bind(c(g("s")), hl.dsp.exec_cmd("XDG_CURRENT_DESKTOP=GNOME gnome-control-center"))
hl.bind(g("d"), hl.dsp.exec_cmd("hyprfocus class:com.mitchellh.ghostty || uwsm app -- ghostty"))
hl.bind(c(g("d")), hl.dsp.exec_cmd("uwsm app -- ghostty"))
hl.bind(g("f"), hl.dsp.exec_cmd("hyprfocus class:zen || uwsm app -- zen-browser"))
hl.bind(c(g("f")), hl.dsp.exec_cmd("uwsm app -- zen-browser --private-window"))
hl.bind(g("g"), hl.dsp.exec_cmd("hyprfocus class:chromium || uwsm app -- chromium"))
hl.bind(c(g("g")), hl.dsp.exec_cmd("uwsm app -- chromium --incognito"))

hl.bind(g("x"), hl.dsp.exec_cmd("hyprfocus class:localsend || GTK_THEME=Adwaita:dark uwsm app -- localsend"))
hl.bind(g("c"), hl.dsp.exec_cmd("hyprclose class:widget.fn || kitty --class=widget.fn -e opencode ~/code/"))
hl.bind(c(g("c")), hl.dsp.exec_cmd("hyprclose class:widget.calc || kitty --class=widget.calc -e calc"))
hl.bind(s(g("c")), hl.dsp.exec_cmd("hyprfocus class:org.gnome.Calendar || uwsm app -- gnome-calendar"))
hl.bind(g("b"), hl.dsp.exec_cmd("vicinae_toggle deeplink vicinae://launch/@Gelei/store.vicinae.bluetooth/devices"))
hl.bind(c(g("b")), hl.dsp.exec_cmd("hyprclose class:widget.bluetui || kitty --class=widget.bluetui -e bluetui"))
hl.bind(g("v"), hl.dsp.exec_cmd("vicinae_toggle deeplink vicinae://launch/clipboard/history"))
hl.bind(c(g("v")), hl.dsp.exec_cmd("hyprclose 'class:Mullvad VPN' || mullvad-vpn"))

hl.bind(c(g("y")), hl.dsp.exec_cmd("hyprclose class:widget.btop || kitty --class=widget.btop -e yazi"))
hl.bind(g("i"), hl.dsp.exec_cmd("screenshot output"))
hl.bind(c(g("i")), hl.dsp.exec_cmd("screenshot region"))
hl.bind(s(g("i")), hl.dsp.exec_cmd("screenshot window"))
hl.bind(g("o"), hl.dsp.exec_cmd("hyprclose class:widget.fn || kitty --class=widget.fn -e fn"))
hl.bind(c(g("o")), hl.dsp.exec_cmd("hyprfocus class:obsidian || uwsm app -- obsidian"))
hl.bind(g("p"), hl.dsp.exec_cmd("hyprfocus class:1Password || uwsm app -- 1password"))
hl.bind(s(g("p")), hl.dsp.exec_cmd("hyprpicker --autocopy"))

hl.bind(g("space"), hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(c(s("space")), hl.dsp.exec_cmd("vicinae_toggle deeplink vicinae://launch/core/search-emojis"))

hl.bind(g("n"), hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(c(g("n")), hl.dsp.exec_cmd("swaync-client -C"))
hl.bind(s(g("n")), hl.dsp.exec_cmd("swaync-client -d"))

hl.bind("print", hl.dsp.exec_cmd("screenshot output"))
hl.bind(g("print"), hl.dsp.exec_cmd("screenshot window"))
hl.bind(c("print"), hl.dsp.exec_cmd("screenshot region"))

---- Window management
hl.bind(g("q"), hl.dsp.window.close())
hl.bind(c(g("x")), hl.dsp.window.kill())
hl.bind(g("m"), hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(c(g("m")), hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(g("r"), hl.dsp.layout("togglesplit"))

-- alt tab
hl.bind(a("tab"), function()
  hl.dispatch(hl.dsp.window.cycle_next({ next = true }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end, { repeating = true })

hl.bind(s(a("tab")), function()
  hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end, { repeating = true })

-- window resizing
hl.bind(g("right"), hl.dsp.window.resize({ x = 300, y = 0, relative = true }))
hl.bind(g("left"), hl.dsp.window.resize({ x = -300, y = 0, relative = true }))
hl.bind(g("down"), hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
hl.bind(g("up"), hl.dsp.window.resize({ x = 0, y = -100, relative = true }))

-- move focus with vim keys
hl.bind(g("h"), hl.dsp.focus({ direction = "left" }))
hl.bind(g("j"), hl.dsp.focus({ direction = "down" }))
hl.bind(g("k"), hl.dsp.focus({ direction = "up" }))
hl.bind(g("l"), hl.dsp.focus({ direction = "right" }))

-- swap windows
hl.bind(s(g("h")), hl.dsp.window.swap({ direction = "left" }))
hl.bind(s(g("j")), hl.dsp.window.swap({ direction = "down" }))
hl.bind(s(g("k")), hl.dsp.window.swap({ direction = "up" }))
hl.bind(s(g("l")), hl.dsp.window.swap({ direction = "right" }))

-- move/resize windows with mouse
hl.bind(g("mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(g("mouse:273"), hl.dsp.window.resize(), { mouse = true })

-- TODO: temporary till there's a keep_aspect_ratio dispatcher
local keep_aspect_resize_window = nil
hl.bind(c(g("mouse:273")), function()
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

hl.bind(c(g("mouse:273")), function()
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
hl.bind(g("y"), hl.dsp.window.float({ action = "toggle" }))

-- move window
hl.bind(c(g("down")), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "down" }))
end)

hl.bind(c(g("left")), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "left" }))
end)

hl.bind(c(g("right")), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "right" }))
end)

hl.bind(c(g("up")), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "up" }))
end)

-- centerwindow (floating only)
hl.bind(g("comma"), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.center())
end)

hl.bind(c(g("comma")), function()
  local monitor = assert(hl.get_active_monitor())
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.resize({ x = monitor.width * 0.75, y = monitor.height * 0.75 }))
  hl.dispatch(hl.dsp.window.center())
end)

-- pin floating window to all spaces
hl.bind(c(g("p")), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.pin())
end)

---- Workspaces
hl.bind(c(g("h")), hl.dsp.focus({ workspace = "-1" }))
hl.bind(c(g("j")), hl.dsp.window.move({ workspace = "-1" }))
hl.bind(c(g("k")), hl.dsp.window.move({ workspace = "+1" }))
hl.bind(c(g("l")), hl.dsp.focus({ workspace = "+1" }))

hl.bind(c(g("space")), hl.dsp.focus({ workspace = "previous" }))

for i = 1, 9 do
  hl.bind(g(i), hl.dsp.focus({ workspace = i }))
  hl.bind(s(g(i)), hl.dsp.window.move({ workspace = i }))
end

hl.bind(g("tab"), hl.dsp.window.move({ workspace = "empty" }))
hl.bind(g("return"), function() -- TODO: till we get workspacemovesilent
  hl.dispatch(hl.dsp.window.move({ workspace = "empty" }))
  hl.dispatch(hl.dsp.focus({ workspace = "previous" }))
end)

-- mouse quick switch
hl.bind(g("mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(g("mouse_up"), hl.dsp.focus({ workspace = "e-1" }))

---- Media keys
-- Only display the OSD on the currently focused monitor
local osdclient = [[swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" ]]

-- Laptop multimedia keys for volume and LCD brightness (with OSD)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(osdclient .. "--output-volume raise"), {
  locked = true,
  repeating = true,
})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(osdclient .. "--output-volume lower"), {
  locked = true,
  repeating = true,
})
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(osdclient .. "--output-volume mute-toggle"), {
  locked = true,
  repeating = true,
})
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(osdclient .. "--input-volume mute-toggle"), {
  locked = true,
  repeating = true,
})
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(osdclient .. "--brightness raise"), {
  locked = true,
  repeating = true,
})
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(osdclient .. "--brightness lower"), {
  locked = true,
  repeating = true,
})

-- Precise 1% multimedia adjustments
hl.bind(c("XF86AudioRaiseVolume"), hl.dsp.exec_cmd(osdclient .. "--output-volume +1"), {
  locked = true,
  repeating = true,
})
hl.bind(c("XF86AudioLowerVolume"), hl.dsp.exec_cmd(osdclient .. "--output-volume -1"), {
  locked = true,
  repeating = true,
})
hl.bind(c("XF86MonBrightnessUp"), hl.dsp.exec_cmd(osdclient .. "--brightness +1"), {
  locked = true,
  repeating = true,
})
hl.bind(c("XF86MonBrightnessDown"), hl.dsp.exec_cmd(osdclient .. "--brightness -1"), {
  locked = true,
  repeating = true,
})

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(osdclient .. "--playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(osdclient .. "--playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(osdclient .. "--playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(osdclient .. "--playerctl previous"), { locked = true })
