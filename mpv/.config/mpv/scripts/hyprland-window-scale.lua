local mp = require("mp")

if not os.getenv("HYPRLAND_INSTANCE_SIGNATURE") then
  return
end

local function resize_window(scale)
  local width = mp.get_property_number("dwidth")
  local height = mp.get_property_number("dheight")
  local pid = mp.get_property_number("pid")

  if not width or not height or not pid then
    mp.osd_message("Window scale unavailable")
    return
  end

  local rotation = mp.get_property_number("video-out-params/rotate", 0)
  if rotation % 180 == 90 then
    width, height = height, width
  end

  width = math.max(1, math.floor(width * scale))
  height = math.max(1, math.floor(height * scale))
  pid = math.floor(pid)

  -- Keep mpv's configured scale in sync even though Hyprland ignores its
  -- Wayland resize request.
  mp.set_property_number("window-scale", scale)

  local dispatcher = ('hl.dsp.window.resize({ x = %d, y = %d, window = "pid:%d" })'):format(width, height, pid)

  mp.command_native_async({
    name = "subprocess",
    playback_only = false,
    capture_stdout = true,
    capture_stderr = true,
    args = { "hyprctl", "dispatch", dispatcher },
  }, function(success, result, error)
    if success and result and result.status == 0 then
      mp.osd_message(string.format("Window scale: %.2f", scale))
      return
    end

    local detail = error or (result and result.stderr) or "unknown error"
    mp.msg.error("Hyprland window resize failed: " .. detail)
    mp.osd_message("Hyprland window resize failed")
  end)
end

mp.add_forced_key_binding("Alt+0", "window-scale-half", function()
  resize_window(0.5)
end)

mp.add_forced_key_binding("Alt+1", "window-scale-normal", function()
  resize_window(1)
end)

mp.add_forced_key_binding("Alt+2", "window-scale-double", function()
  resize_window(2)
end)
