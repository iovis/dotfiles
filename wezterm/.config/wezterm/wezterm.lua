-- https://wezfurlong.org/wezterm/config/lua/general.html

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

----UI
config.color_scheme = "Default Dark (base16)"

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 20

config.exit_behavior = "Close"
config.hide_tab_bar_if_only_one_tab = true
config.macos_window_background_blur = 20
config.window_background_opacity = 0.8
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

----Keymaps
-- config.use_dead_keys = false
config.disable_default_key_bindings = true

-- wezterm show-keys --lua
config.keys = {
  { key = "-", mods = "CTRL", action = wezterm.action({ SendString = "\x1f" }) }, -- Enable C-_

  { key = "+", mods = "SUPER", action = act.IncreaseFontSize },
  { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
  { key = "0", mods = "SUPER", action = act.ResetFontSize },
  { key = "L", mods = "SUPER", action = act.ShowDebugOverlay },
  { key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
  { key = "f", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
  { key = "h", mods = "SUPER", action = act.HideApplication },
  { key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackOnly") },
  { key = "m", mods = "SUPER", action = act.Hide },
  { key = "n", mods = "SUPER", action = act.SpawnWindow },
  { key = "q", mods = "SUPER", action = act.QuitApplication },
  { key = "r", mods = "SUPER", action = act.ReloadConfiguration },
  { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
  { key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
}

return config
