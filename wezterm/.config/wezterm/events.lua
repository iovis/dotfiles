local wezterm = require("wezterm")

wezterm.on("toggle-opacity", function(window, _pane)
  local overrides = window:get_config_overrides() or {}

  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 1
  else
    overrides.window_background_opacity = nil
  end

  window:set_config_overrides(overrides)
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  return {
    { Text = " " .. tab.active_pane.title .. " " },
  }
end)
