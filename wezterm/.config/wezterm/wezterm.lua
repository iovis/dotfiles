-- https://wezfurlong.org/wezterm/config/lua/general.html
require("events")

local wezterm = require("wezterm")
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

config.window_padding = {
  left = "1cell",
  right = "1cell",
  top = "1cell",
  bottom = "0.5cell",
}

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
-- wezterm show-keys --lua
config.disable_default_key_bindings = true
-- config.use_dead_keys = false
config.keys = require("keymap")

----Hyperlinks
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = "https://www.github.com/$1/$3",
})

-- JIRA cards (PE-411)
table.insert(config.hyperlink_rules, {
  regex = [[([A-Z]+-\d+)]],
  format = "https://rubiconmd.atlassian.net/browse/$1",
})

return config
