hs.hotkey.bind({ "shift" }, "`", function()
  hs.eventtap.keyStrokes("^")
end)

hs.hotkey.bind({}, "`", function()
  hs.eventtap.keyStrokes("`")
end)

local defy = false
if defy then
  hs.hotkey.bind({ "alt", "shift" }, "+", function()
    hs.eventtap.keyStrokes("]")
  end)

  hs.hotkey.bind({ "alt" }, "+", function()
    hs.eventtap.keyStrokes("[")
  end)

  hs.hotkey.bind({ "alt", "shift" }, "return", function()
    hs.eventtap.keyStrokes("}")
  end)

  hs.hotkey.bind({ "alt" }, "return", function()
    hs.eventtap.keyStrokes("{")
  end)
end

---Debug keystrokes
local debug = false

if debug then
  print(hs.inspect(hs.keycodes.map))

  local tap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    print(hs.inspect(event:getRawEventData()))
  end)

  tap:start()
end
