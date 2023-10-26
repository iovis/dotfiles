hs.hotkey.bind({ "shift" }, "`", function()
  hs.eventtap.keyStrokes("^")
end)

hs.hotkey.bind({}, "`", function()
  hs.eventtap.keyStrokes("`")
end)

-- TODO: Only enable when using the Defy
-- hs.hotkey.bind({ "alt", "shift" }, "+", function()
--   hs.eventtap.keyStrokes("]")
-- end)
--
-- hs.hotkey.bind({ "alt" }, "+", function()
--   hs.eventtap.keyStrokes("[")
-- end)
--
-- hs.hotkey.bind({ "alt", "shift" }, "return", function()
--   hs.eventtap.keyStrokes("}")
-- end)
--
-- hs.hotkey.bind({ "alt" }, "return", function()
--   hs.eventtap.keyStrokes("{")
-- end)

---Debug keystrokes
-- print(hs.inspect(hs.keycodes.map))
--
-- tap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
--   print(hs.inspect(event:getRawEventData()))
-- end)
--
-- tap:start()
