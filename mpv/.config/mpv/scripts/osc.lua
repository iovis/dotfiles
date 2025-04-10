-- show OSC on seek
mp.register_event("seek", function()
  mp.commandv("script-message", "osc-show")
end)
