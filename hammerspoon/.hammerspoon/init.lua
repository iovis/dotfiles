---Generate EmmyLua annotations
-- hs.loadSpoon("EmmyLua")

---Key Overrides
-- print(hs.inspect(hs.keycodes.map))
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "r", function()
  hs.reload()
end)

hs.hotkey.bind({ "alt", "shift" }, "+", function()
  hs.eventtap.keyStrokes("]")
end)

hs.hotkey.bind({ "alt" }, "+", function()
  hs.eventtap.keyStrokes("[")
end)

hs.hotkey.bind({ "shift" }, "`", function()
  hs.eventtap.keyStrokes("^")
end)

hs.hotkey.bind({}, "`", function()
  hs.eventtap.keyStrokes("`")
end)

hs.hotkey.bind({ "alt", "shift" }, "return", function()
  hs.eventtap.keyStrokes("}")
end)

hs.hotkey.bind({ "alt" }, "return", function()
  hs.eventtap.keyStrokes("{")
end)

---Debug keystrokes
-- local tap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
--   print(hs.inspect(event:getRawEventData()))
-- end)
-- tap:start()

hs.notify.new({ title = "Hammerspoon", informativeText = "Configuration Reloaded" }):send()
