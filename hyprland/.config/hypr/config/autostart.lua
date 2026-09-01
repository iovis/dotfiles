-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start hyprpaper.service")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("systemctl --user start swaync.service")
  hl.exec_cmd("systemctl --user start vicinae.service")

  hl.exec_cmd("uwsm-app -- swayosd-server")
  hl.exec_cmd("uwsm-app -- udiskie")
  hl.exec_cmd("systemctl --user start waybar.service")

  -- GNOME housekeeping (nautilus)
  hl.exec_cmd("uwsm-app -- /usr/lib/gsd-housekeeping")

  -- Don't run as a service to be able to control inhibit
  hl.exec_cmd("uwsm-app -- hypridle")
end)
