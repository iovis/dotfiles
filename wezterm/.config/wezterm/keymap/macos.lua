local wezterm = require("wezterm")
local act = wezterm.action

-- wezterm show-keys --lua
return {
  { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
  { key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
  { key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
  { key = "+", mods = "SUPER", action = act.IncreaseFontSize },
  { key = "-", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
  { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
  { key = "0", mods = "SUPER", action = act.ResetFontSize },
  { key = "1", mods = "SUPER", action = act.ActivateTab(0) },
  { key = "2", mods = "SUPER", action = act.ActivateTab(1) },
  { key = "3", mods = "SUPER", action = act.ActivateTab(2) },
  { key = "4", mods = "SUPER", action = act.ActivateTab(3) },
  { key = "5", mods = "SUPER", action = act.ActivateTab(4) },
  { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
  { key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
  { key = "f", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
  { key = "h", mods = "SUPER", action = act.HideApplication },
  { key = "l", mods = "SUPER", action = act.ShowDebugOverlay }, -- window:effective_config()
  { key = "m", mods = "SUPER", action = act.Hide },
  { key = "n", mods = "SHIFT|CTRL", action = act.SpawnWindow },
  { key = "n", mods = "SUPER", action = act.SpawnWindow },
  { key = "q", mods = "SUPER", action = act.QuitApplication },
  { key = "t", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "u", mods = "SUPER", action = act.EmitEvent("toggle-opacity") },
  { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
  { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
  { key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = false }) },
  { key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = false }) },
}
