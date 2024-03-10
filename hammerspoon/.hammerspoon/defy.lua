local defy_enabled = false
if not defy_enabled then
  return
end

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
