local mp = require("mp")

local hold_delay = 0.100
local hold_timer
local original_speed

local function start_speedup()
  hold_timer = nil
  original_speed = mp.get_property_number("speed", 1)
  mp.set_property_number("speed", original_speed * 2)
end

local function finish_press(event)
  if hold_timer then
    hold_timer:kill()
    hold_timer = nil

    if not event.canceled then
      mp.commandv("cycle", "pause")
    end
  elseif original_speed then
    mp.set_property_number("speed", original_speed)
    original_speed = nil
  end
end

local function handle_space(event)
  if event.event == "down" and not event.canceled then
    if not hold_timer and not original_speed then
      hold_timer = mp.add_timeout(hold_delay, start_speedup)
    end
  elseif event.event == "up" or event.canceled then
    finish_press(event)
  elseif event.event == "press" then
    mp.commandv("cycle", "pause")
  end
end

mp.add_key_binding(nil, "tap-pause-hold-speed", handle_space, {
  complex = true,
})
