muxi.uppercase_overrides = true
muxi.use_current_pane_path = true

muxi.editor = {
  args = {
    "+ZenMode",
    "-c",
    "nmap q <cmd>silent wqa<cr>",
  },
}

muxi.fzf = {
  input = false,
  bind_sessions = false,
  args = {
    "--bind=alt-/:abort",
  },
}

-- muxi.bindings = {
--   ["/"] = { command = "muxi fzf" },
-- }

-- print(require("inspect")(muxi))
