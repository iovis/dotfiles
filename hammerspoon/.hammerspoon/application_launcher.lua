---@param binding HammerspoonBinding
---@param application string
local function bind(binding, application)
  hs.hotkey.bind(binding[1], binding[2], function()
    hs.application.launchOrFocus(application)
  end)
end

bind({ ctrl_alt_cmd, "a" }, "Things3")
bind({ ctrl_alt_cmd, "s" }, "Slack")
bind({ ctrl_alt_cmd, "d" }, "WezTerm")
bind({ ctrl_alt_cmd, "f" }, "Arc")
bind({ ctrl_alt_cmd, "g" }, "Google Chrome Canary")

bind({ ctrl_alt_cmd, "w" }, "Messages")
bind({ ctrl_alt_cmd, "e" }, "Spark Desktop")
bind({ ctrl_alt_cmd, "t" }, "TablePlus")

bind({ ctrl_alt_cmd, "z" }, "zoom.us")
bind({ ctrl_alt_cmd, "x" }, "Music")
bind({ ctrl_alt_cmd, "c" }, "Fantastical")
bind({ ctrl_alt_cmd, "b" }, "Obsidian")

bind({ ctrl_alt_cmd, "i" }, "IINA")
