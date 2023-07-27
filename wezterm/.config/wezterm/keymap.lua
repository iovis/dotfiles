local wezterm = require("wezterm")
local act = wezterm.action

return {
  { key = "-", mods = "CTRL", action = wezterm.action({ SendString = "\x1f" }) }, -- Enable C-_
  { key = "ñ", mods = "ALT", action = wezterm.action({ SendString = "~" }) },
  { key = "+", mods = "ALT", action = wezterm.action({ SendString = "]" }) },
  { key = "ç", mods = "ALT", action = wezterm.action({ SendString = "}" }) },

  { key = "+", mods = "SUPER", action = act.IncreaseFontSize },
  { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
  { key = "0", mods = "SUPER", action = act.ResetFontSize },
  { key = "1", mods = "SUPER", action = act.ActivateTab(0) },
  { key = "2", mods = "SUPER", action = act.ActivateTab(1) },
  { key = "3", mods = "SUPER", action = act.ActivateTab(2) },
  { key = "4", mods = "SUPER", action = act.ActivateTab(3) },
  { key = "5", mods = "SUPER", action = act.ActivateTab(4) },
  { key = "6", mods = "SUPER", action = act.ActivateTab(5) },
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
  { key = "u", mods = "SUPER", action = act.EmitEvent("toggle-opacity") },
  { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
  { key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
}
