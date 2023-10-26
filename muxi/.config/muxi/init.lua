-- TODO: Add EmmyLua annotations

-- TODO: Add to muxi?
local inspect = require("inspect")

local nvim_opts = "+ZenMode -c 'nmap <silent> q :wqa<cr>'"

muxi.uppercase_overrides = true
muxi.bindings = {
  ["-"] = {
    command = "muxi fzf",
  },
  c = {
    popup = { title = " config ", height = "66%" },
    command = ("muxi config edit -- %s"):format(nvim_opts),
  },
  e = {
    popup = { title = " sessions ", height = "66%" },
    command = ("muxi sessions edit -- %s"):format(nvim_opts),
  },
  ["ñ"] = {
    command = "muxi sessions switch ñ",
  },
  ["Ñ"] = {
    command = "muxi sessions set ñ && tmux display 'bound current session to ñ'",
  },
}

-- print(inspect(muxi))
