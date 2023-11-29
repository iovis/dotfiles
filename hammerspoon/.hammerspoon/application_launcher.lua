local function bind(modifiers, key, application)
  hs.hotkey.bind(modifiers, key, function()
    hs.application.launchOrFocus(application)
  end)
end

bind(ctrl_alt_cmd, "a", "Things3")
bind(ctrl_alt_cmd, "s", "Slack")
bind(ctrl_alt_cmd, "d", "WezTerm")
bind(ctrl_alt_cmd, "f", "Arc")
bind(ctrl_alt_cmd, "g", "Tower")

bind(ctrl_alt_cmd, "w", "Messages")
bind(ctrl_alt_cmd, "e", "Mail")

bind(ctrl_alt_cmd, "z", "zoom.us")
bind(ctrl_alt_cmd, "x", "Music")
bind(ctrl_alt_cmd, "c", "Fantastical")
bind(ctrl_alt_cmd, "b", "Bear")

bind(ctrl_alt_cmd, "i", "IINA")
bind(ctrl_alt_cmd, "n", "Numi")
