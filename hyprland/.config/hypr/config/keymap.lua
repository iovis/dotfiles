-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- NOTE: use `wev` to see key names

local function G(key)
  return ("SUPER + %s"):format(key)
end

local function C(key)
  return ("CTRL + %s"):format(key)
end

local function S(key)
  return ("SHIFT + %s"):format(key)
end

local function A(key)
  return ("ALT + %s"):format(key)
end

---- Power management
local logout = "loginctl terminate user david"
local powermenu = "hyprclose class:widget.powermenu || kitty --class=widget.powermenu -e powermenu"
local screensaver = "kitty --class=widget.screensaver -o background_opacity=1 -o background=black -e cmatrix -bsk"
hl.bind(C(G("q")), hl.dsp.exec_cmd(logout))
hl.bind(G("backspace"), hl.dsp.exec_cmd(screensaver))
hl.bind(C(G("backspace")), hl.dsp.exec_cmd(powermenu))

---- Applications
-- `hyprctl clients -j | jq '.[].class'`
hl.bind(G("w"), hl.dsp.exec_cmd("pkill gnome-weather || uwsm app -- gnome-weather"))
hl.bind(C(G("w")), hl.dsp.exec_cmd("pkill waybar || uwsm app -- waybar"))
hl.bind(G("e"), hl.dsp.exec_cmd("hyprfocus class:org.gnome.Nautilus || uwsm app -- nautilus"))
hl.bind(C(G("e")), hl.dsp.exec_cmd("uwsm app -- nautilus --new-window"))
hl.bind(G("t"), hl.dsp.exec_cmd("hyprclose class:widget.btop || kitty --class=widget.btop -e btop"))
hl.bind(C(G("t")), hl.dsp.exec_cmd("hyprclose class:widget.btop || kitty --class=widget.btop -e htop"))

hl.bind(G("a"), hl.dsp.exec_cmd("hyprclose class:widget.wiremix || kitty --class=widget.wiremix -e wiremix"))
hl.bind(S(G("a")), hl.dsp.exec_cmd("hyprfocus class:org.pulseaudio.pavucontrol || uwsm app -- pavucontrol"))
hl.bind(G("s"), hl.dsp.exec_cmd("hyprfocus class:steam || STEAM_RUNTIME=1 steam -no-cef-sandbox -cef-force-glx"))
hl.bind(C(G("s")), hl.dsp.exec_cmd("XDG_CURRENT_DESKTOP=GNOME gnome-control-center"))
hl.bind(G("d"), hl.dsp.exec_cmd("hyprfocus class:com.mitchellh.ghostty || uwsm app -- ghostty"))
hl.bind(C(G("d")), hl.dsp.exec_cmd("uwsm app -- ghostty"))
hl.bind(G("f"), hl.dsp.exec_cmd("hyprfocus class:zen || uwsm app -- zen-browser"))
hl.bind(C(G("f")), hl.dsp.exec_cmd("uwsm app -- zen-browser --private-window"))
hl.bind(G("G"), hl.dsp.exec_cmd("hyprfocus class:chromium || uwsm app -- chromium"))
hl.bind(C(G("g")), hl.dsp.exec_cmd("uwsm app -- chromium --incognito"))

hl.bind(G("x"), hl.dsp.exec_cmd("hyprfocus class:localsend || GTK_THEME=Adwaita:dark uwsm app -- localsend"))
hl.bind(G("c"), hl.dsp.exec_cmd("hyprclose class:widget.fn || kitty --class=widget.fn -e codex --cd ~/code/"))
hl.bind(C(G("c")), hl.dsp.exec_cmd("hyprclose class:widget.calc || kitty --class=widget.calc -e calc"))
hl.bind(S(G("c")), hl.dsp.exec_cmd("hyprfocus class:org.gnome.Calendar || uwsm app -- gnome-calendar"))
hl.bind(G("b"), hl.dsp.exec_cmd("vicinae_toggle deeplink vicinae://launch/@Gelei/store.vicinae.bluetooth/devices"))
hl.bind(C(G("b")), hl.dsp.exec_cmd("hyprclose class:widget.bluetui || kitty --class=widget.bluetui -e bluetui"))
hl.bind(G("v"), hl.dsp.exec_cmd("vicinae_toggle deeplink vicinae://launch/clipboard/history"))
hl.bind(C(G("v")), hl.dsp.exec_cmd("hyprclose 'class:Mullvad VPN' || mullvad-vpn"))

hl.bind(C(G("y")), hl.dsp.exec_cmd("hyprclose class:widget.btop || kitty --class=widget.btop -e yazi"))
hl.bind(G("i"), hl.dsp.exec_cmd("hyprclose class:widget.wiremix || kitty --class=widget.wiremix -e impala"))
hl.bind(C(G("i")), hl.dsp.exec_cmd("hypridle_toggle"))
hl.bind(G("o"), hl.dsp.exec_cmd("hyprclose class:widget.fn || kitty --class=widget.fn -e fn"))
hl.bind(C(G("o")), hl.dsp.exec_cmd("hyprfocus class:obsidian || uwsm app -- obsidian"))
hl.bind(G("p"), hl.dsp.exec_cmd("hyprfocus class:1Password || uwsm app -- 1password"))
hl.bind(S(G("p")), hl.dsp.exec_cmd("hyprpicker --autocopy"))

hl.bind(G("space"), hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(C(S("space")), hl.dsp.exec_cmd("vicinae_toggle deeplink vicinae://launch/core/search-emojis"))

hl.bind(G("n"), hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(G("semicolon"), hl.dsp.exec_cmd("swaync-client -C"))
hl.bind(C(G("semicolon")), hl.dsp.exec_cmd("swaync-client -d"))

hl.bind("print", hl.dsp.exec_cmd("screenshot output"))
hl.bind(G("print"), hl.dsp.exec_cmd("screenshot window"))
hl.bind(C("print"), hl.dsp.exec_cmd("screenshot region"))

---- Screenshots
hl.bind(C(G("3")), hl.dsp.exec_cmd("screenshot output"))
hl.bind(C(G("4")), hl.dsp.exec_cmd("screenshot region"))
hl.bind(C(G("5")), hl.dsp.exec_cmd("screenrecord"))
hl.bind(C(G("6")), hl.dsp.exec_cmd("screenshot window"))

---- Window management
hl.bind(G("q"), hl.dsp.window.close())
hl.bind(C(G("x")), hl.dsp.window.kill())
hl.bind(G("m"), hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(C(G("m")), hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(G("r"), hl.dsp.layout("togglesplit"))

-- alt tab
hl.bind(A("tab"), function()
  hl.dispatch(hl.dsp.window.cycle_next({ next = true }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end, { repeating = true })

hl.bind(S(A("tab")), function()
  hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end, { repeating = true })

-- window resizing
hl.bind(G("right"), hl.dsp.window.resize({ x = 300, y = 0, relative = true }))
hl.bind(G("left"), hl.dsp.window.resize({ x = -300, y = 0, relative = true }))
hl.bind(G("down"), hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
hl.bind(G("up"), hl.dsp.window.resize({ x = 0, y = -100, relative = true }))

hl.bind(C(G("right")), hl.dsp.window.resize({ x = 30, y = 0, relative = true }))
hl.bind(C(G("left")), hl.dsp.window.resize({ x = -30, y = 0, relative = true }))
hl.bind(C(G("down")), hl.dsp.window.resize({ x = 0, y = 30, relative = true }))
hl.bind(C(G("up")), hl.dsp.window.resize({ x = 0, y = -30, relative = true }))

-- move focus with vim keys
hl.bind(G("h"), hl.dsp.focus({ direction = "left" }))
hl.bind(G("j"), hl.dsp.focus({ direction = "down" }))
hl.bind(G("k"), hl.dsp.focus({ direction = "up" }))
hl.bind(G("l"), hl.dsp.focus({ direction = "right" }))

-- swap windows
hl.bind(S(G("h")), hl.dsp.window.swap({ direction = "left" }))
hl.bind(S(G("j")), hl.dsp.window.swap({ direction = "down" }))
hl.bind(S(G("k")), hl.dsp.window.swap({ direction = "up" }))
hl.bind(S(G("l")), hl.dsp.window.swap({ direction = "right" }))

-- move/resize windows with mouse
hl.bind(G("mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(G("mouse:273"), hl.dsp.window.resize(), { mouse = true })

-- TODO: temporary till there's a keep_aspect_ratio dispatcher
local keep_aspect_resize_window = nil
hl.bind(C(G("mouse:273")), function()
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

hl.bind(C(G("mouse:273")), function()
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
hl.bind(G("y"), hl.dsp.window.float({ action = "toggle" }))

-- move window
hl.bind(S(G("down")), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "down" }))
end)

hl.bind(S(G("left")), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "left" }))
end)

hl.bind(S(G("right")), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "right" }))
end)

hl.bind(S(G("up")), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.move({ direction = "up" }))
end)

-- centerwindow (floating only)
hl.bind(G("comma"), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.center())
end)

hl.bind(C(G("comma")), function()
  local monitor = assert(hl.get_active_monitor())
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.resize({ x = monitor.width * 0.75, y = monitor.height * 0.75 }))
  hl.dispatch(hl.dsp.window.center())
end)

-- pin floating window to all spaces
hl.bind(C(G("p")), function()
  hl.dispatch(hl.dsp.window.float({ action = "enable" }))
  hl.dispatch(hl.dsp.window.pin())
end)

---- Workspaces
hl.bind(C(G("h")), hl.dsp.focus({ workspace = "-1" }))
hl.bind(C(G("j")), hl.dsp.window.move({ workspace = "-1" }))
hl.bind(C(G("k")), hl.dsp.window.move({ workspace = "+1" }))
hl.bind(C(G("l")), hl.dsp.focus({ workspace = "+1" }))

hl.bind(C(G("space")), hl.dsp.focus({ workspace = "previous" }))

for i = 1, 9 do
  hl.bind(G(i), hl.dsp.focus({ workspace = i }))
  hl.bind(S(G(i)), hl.dsp.window.move({ workspace = i }))
end

hl.bind(G("tab"), hl.dsp.window.move({ workspace = "empty" }))
hl.bind(G("return"), function() -- TODO: till we get workspacemovesilent
  hl.dispatch(hl.dsp.window.move({ workspace = "empty" }))
  hl.dispatch(hl.dsp.focus({ workspace = "previous" }))
end)

-- mouse quick switch
hl.bind(G("mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(G("mouse_up"), hl.dsp.focus({ workspace = "e-1" }))

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
hl.bind(C("XF86AudioRaiseVolume"), hl.dsp.exec_cmd(osdclient .. "--output-volume +1"), {
  locked = true,
  repeating = true,
})
hl.bind(C("XF86AudioLowerVolume"), hl.dsp.exec_cmd(osdclient .. "--output-volume -1"), {
  locked = true,
  repeating = true,
})
hl.bind(C("XF86MonBrightnessUp"), hl.dsp.exec_cmd(osdclient .. "--brightness +1"), {
  locked = true,
  repeating = true,
})
hl.bind(C("XF86MonBrightnessDown"), hl.dsp.exec_cmd(osdclient .. "--brightness -1"), {
  locked = true,
  repeating = true,
})

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(osdclient .. "--playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(osdclient .. "--playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(osdclient .. "--playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(osdclient .. "--playerctl previous"), { locked = true })
