-- local nvim_opts = "+ZenMode -c 'nmap q <cmd>silent wqa<cr>'"

muxi.uppercase_overrides = true
muxi.use_current_pane_path = true
muxi.bindings = {
  ["/"] = {
    command = "muxi fzf",
  },
}

-- print(require("inspect")(muxi))
