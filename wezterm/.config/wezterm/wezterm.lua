-- https://wezfurlong.org/wezterm/config/lua/general.html

---@type Wezterm
local wezterm = require("wezterm")
local config = wezterm.config_builder()

----Events
require("events")

----Config
config:set_strict_mode(true)

---UI
config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"
config.color_scheme = "Catppuccin Mocha"
config.enable_kitty_keyboard = true
config.exit_behavior = "Close"
config.hide_tab_bar_if_only_one_tab = true
config.macos_window_background_blur = 20
config.max_fps = 120
config.scrollback_lines = 5000
config.window_background_opacity = 0.85
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

config.window_padding = {
  left = "1cell",
  right = "1cell",
  top = "1cell",
  bottom = "0.5cell",
}

local transparent_black = "rgba(0, 0, 0, 0.85)"

config.window_frame = {
  active_titlebar_bg = transparent_black,
  inactive_titlebar_bg = transparent_black,
  font_size = 15,
  font = wezterm.font({
    family = "FiraCode Nerd Font",
    weight = "Bold",
  }),
}

-- R=require("catppuccin.palettes").get_palette()
config.colors = {
  background = "black",
  tab_bar = {
    inactive_tab_edge = "#000",
    active_tab = {
      bg_color = "#000",
      fg_color = "#fff",
    },
    inactive_tab = {
      bg_color = "#000",
      fg_color = "#555",
    },
    new_tab = {
      bg_color = "#000",
      fg_color = "#555",
    },
    new_tab_hover = {
      bg_color = "#000",
      fg_color = "#fff",
    },
    inactive_tab_hover = {
      bg_color = "#222",
      fg_color = "#fff",
    },
  },
}

---Fonts
-- config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- Disable ligatures
-- wezterm ls-fonts --list-system | rg Fira
-- wezterm ls-fonts --text "✔"
config.font_size = 20
config.font = wezterm.font_with_fallback({
  { family = "FiraCode Nerd Font", weight = 450 }, -- Retina
  "Menlo", -- This has the check mark and cross symbols
  "Apple Color Emoji",
})

---Keymaps
-- wezterm show-keys --lua
config.disable_default_key_bindings = true

if wezterm.target_triple == "aarch64-apple-darwin" then
  config.keys = require("keymap.macos")
else
  config.keys = require("keymap.linux")
end

---Hyperlinks
require("hyperlinks")
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make username/project paths clickable (with shift+click). this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[([-\w\d]+/[-\w\d\.]+)]],
  format = "https://www.github.com/$1",
})

----Linux
if wezterm.target_triple ~= "aarch64-apple-darwin" then
  config.font_size = 16
  config.enable_wayland = false
  -- config.front_end = "WebGpu" -- OpenGL, Software, WebGpu
  config.window_background_opacity = 0.7
end

----Local configuration
local ok, locals = pcall(require, "locals")
if ok then
  locals.overrides(config)
end

-- JIRA cards (PE-411)
if JIRA_URL then
  table.insert(config.hyperlink_rules, {
    regex = [[([A-Z]+-\d+)]],
    format = JIRA_URL,
  })
end

return config
