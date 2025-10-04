-- print(require("inspect")(muxi))

return {
  uppercase_overrides = true,
  use_current_pane_path = true,
  editor = {
    args = { "+ZenMode", "-c", "nmap q <cmd>silent wqa<cr>" },
  },
  fzf = {
    input = false,
    bind_sessions = false,
  },
  -- bindings = {
  --   ["/"] = { command = "muxi fzf" },
  -- },
}
