hs.hotkey.bind(hyper, "c", hs.toggleConsole)
hs.hotkey.bind(ctrl_alt_cmd, "r", hs.reload)

---Debug keystrokes in console
local debug = false
if debug then
  print(hs.inspect(hs.keycodes.map))

  local tap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    print(hs.inspect(event:getRawEventData()))
  end)

  tap:start()
end

----Dead Keys
-- hs.hotkey.bind({ "shift" }, "`", function()
--   hs.eventtap.keyStrokes("^")
-- end)
--
-- hs.hotkey.bind({}, "`", function()
--   hs.eventtap.keyStrokes("`")
-- end)
