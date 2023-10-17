---Console
hs.console.darkMode(true)
hs.console.consoleCommandColor({ white = 0.6 })
hs.console.consolePrintColor({ white = 1 })
hs.console.consoleResultColor({ white = 0.8 })
hs.console.outputBackgroundColor({ white = 0.12 })

---Globals
---@diagnostic disable: lowercase-global
ctrl_alt = { "ctrl", "alt" }
ctrl_alt_cmd = { "ctrl", "alt", "cmd" }
hyper = { "ctrl", "cmd", "alt", "shift" }

function notify(message)
  hs.notify
    .new({
      title = "Hammerspoon",
      informativeText = message,
      withdrawAfter = 2,
    })
    :send()
end

-- hs.loadSpoon("EmmyLua") -- Generate EmmyLua annotations
require("application_launcher")
require("bindings")
require("key_overrides")
require("yabai")

notify("Configuration Reloaded")
