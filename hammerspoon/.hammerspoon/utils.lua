---@alias HammerspoonBinding
---|{ [1]: string[], [2]: string }

---Show a Hammerspoon Notification
---@param message string
local function notify(message)
  hs.notify
    .new({
      title = "Hammerspoon",
      informativeText = message,
      withdrawAfter = 2,
    })
    :send()
end

---Run a command with an optional notification
---@param command string
---@param notification? { success_message: string, error: boolean }
local function task(command, notification)
  notification = notification or {}

  return hs.task.new(os.getenv("SHELL"), function(code, stdout, stderr)
    if notification.success_message and code == 0 then
      notify(notification.success_message)
    elseif code ~= 0 then
      print(code)
      print(stdout)
      print(stderr)

      if stderr:match("Can't connect to AeroSpace server.") then
        notify("AeroSpace is not running")
      end

      if notification.error then
        notify("Error running command: " .. command)
        hs.toggleConsole()
      end
    end
  end, { "-c", command })
end

return {
  notify = notify,
  task = task,
  bind = {
    ---@param binding HammerspoonBinding
    ---@param application string
    app = function(binding, application)
      hs.hotkey.bind(binding[1], binding[2], function()
        hs.application.launchOrFocus(application)
      end)
    end,
    ---Binds a command to run with an optional notification
    ---@param binding HammerspoonBinding
    ---@param command string
    ---@param notification? { success_message: string, error: boolean }
    cmd = function(binding, command, notification)
      hs.hotkey.bind(binding[1], binding[2], function()
        task(command, notification):start()
      end)
    end,
    ---Binds a floating-window layout through AeroSpace and macOS native tiling
    ---@param binding HammerspoonBinding
    ---@param os_shortcut HammerspoonBinding
    float_layout = function(binding, os_shortcut)
      hs.hotkey.bind(binding[1], binding[2], function()
        hs.task
          .new(os.getenv("SHELL"), function(_code, _stdout, _stderr)
            hs.eventtap.keyStroke(os_shortcut[1], os_shortcut[2])
          end, { "-c", "aerospace layout floating" })
          :start()
      end)
    end,
    ---Binds a command to a reusable terminal popup layout
    ---@param binding HammerspoonBinding
    ---@param command string
    ---@param options { layout: table, title?: string, launch_or_focus?: boolean }
    popup = function(binding, command, options)
      assert(type(options) == "table" and options.layout, "Terminal popup options require a layout")
      assert(not options.launch_or_focus or options.title, "launch_or_focus requires a unique terminal popup title")

      local popup_options = {
        layout = options.layout,
        title = options.title or ("popup:" .. hs.host.uuid()),
        launch_or_focus = options.launch_or_focus,
      }

      hs.hotkey.bind(binding[1], binding[2], function()
        require("terminal_popups").open(command, popup_options)
      end)
    end,
  },
}
