-- https://wezfurlong.org/wezterm/config/lua/general.html

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config:set_strict_mode(true)

----UI
config.adjust_window_size_when_changing_font_size = false
config.color_scheme = "Default Dark (base16)"
config.exit_behavior = "Close"
config.hide_tab_bar_if_only_one_tab = true
config.macos_window_background_blur = 20
config.scrollback_lines = 5000
config.window_background_opacity = 0.8
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

---Fonts
-- wezterm ls-fonts --list-system | rg Fira
-- wezterm ls-fonts --text "✔"
config.font_size = 19
config.font = wezterm.font_with_fallback({
  "FiraCode Nerd Font",
  "Menlo", -- This has the check mark and cross symbols
  "Apple Color Emoji",
})

config.window_frame = {
  font = wezterm.font({
    family = "FiraCode Nerd Font",
    weight = "Regular",
  }),
}

----Keymaps
config.disable_default_key_bindings = true
-- config.use_dead_keys = false

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
  { key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
  { key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "1", mods = "SUPER", action = act.ActivateTab(0) },
  { key = "2", mods = "SUPER", action = act.ActivateTab(1) },
  { key = "3", mods = "SUPER", action = act.ActivateTab(2) },
  { key = "4", mods = "SUPER", action = act.ActivateTab(3) },
  { key = "5", mods = "SUPER", action = act.ActivateTab(4) },
  { key = "6", mods = "SUPER", action = act.ActivateTab(5) },
}

return config
