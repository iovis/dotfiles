---@alias HammerspoonBinding
---|{ [1]: string[], [2]: string }

---Show a Hammerspoon Notification
---@param message string
local notify = function(message)
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
local task = function(command, notification)
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
  },
}
