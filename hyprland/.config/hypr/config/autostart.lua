-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start hyprpaper.service")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("systemctl --user start swaync.service")
  hl.exec_cmd("systemctl --user start vicinae.service")

  hl.exec_cmd("uwsm-app -- swayosd-server")
  hl.exec_cmd("uwsm-app -- udiskie")

  -- Ensure Waybar's initial idle indicator sees hypridle running.
  hl.exec_cmd("systemctl --user start hypridle.service; systemctl --user start waybar.service")

  -- GNOME housekeeping (nautilus)
  hl.exec_cmd("uwsm-app -- /usr/lib/gsd-housekeeping")
end)
