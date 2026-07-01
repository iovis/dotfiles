local u = require("utils")

----------------------
-- Floating Windows --
----------------------
---Use native window tiling
---@param binding HammerspoonBinding
---@param os_shortcut HammerspoonBinding
local function float_layout(binding, os_shortcut)
  hs.hotkey.bind(binding[1], binding[2], function()
    hs.task
      .new(os.getenv("SHELL"), function(code, stdout, stderr)
        if code == 0 then
          hs.eventtap.keyStroke(os_shortcut[1], os_shortcut[2])
        else
          print(code)
          print(stdout)
          print(stderr)

          if stderr:match("Can't connect to AeroSpace server.") then
            u.notify("AeroSpace is not running")
          end
        end
      end, { "-c", "aerospace layout floating" })
      :start()
  end)
end

---Halves (TODO: not working with fn+ctrl+arrow, so I had to remap at OS level)
float_layout({ ctrl_shift, "h" }, { hyper, "left" })
float_layout({ ctrl_shift, "l" }, { hyper, "right" })

---Fourths (no default mapping, had to give it one at OS level)
float_layout({ ctrl_shift, "u" }, { hyper, "t" })
float_layout({ ctrl_shift, "o" }, { hyper, "w" })
float_layout({ ctrl_shift, "m" }, { hyper, "z" })
float_layout({ ctrl_shift, "." }, { hyper, "x" })

---Centered
float_layout({ ctrl_shift, "k" }, { fn_ctrl, "f" })
float_layout({ ctrl_shift, "j" }, { fn_ctrl, "c" })
float_layout({ ctrl_shift, ";" }, { fn_ctrl, "r" })
