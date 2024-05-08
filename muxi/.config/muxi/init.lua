-- TODO: Add EmmyLua annotations

-- TODO: Add to muxi?
local inspect = require("inspect")

local nvim_opts = "+ZenMode -c 'nmap q <cmd>silent wqa<cr>'"
local fzf_opts = (
  [[--bind "ctrl-r:execute(muxi sessions edit -- %s)+reload(muxi sessions list)" ]]
  .. [[--bind "ctrl-g:execute(muxi config edit -- %s)+reload(muxi sessions list)"]]
):format(nvim_opts, nvim_opts)

muxi.uppercase_overrides = true
muxi.use_current_pane_path = true
muxi.bindings = {
  -- TODO: Allow optional `table: 'root|prefix|muxi|...'`
  ["/"] = {
    command = ("muxi fzf -- %s"):format(fzf_opts),
    -- command = "muxi sessions switch --tmux-menu",
  },
}

-- print(inspect(muxi))
