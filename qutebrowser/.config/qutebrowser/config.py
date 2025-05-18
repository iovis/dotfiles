# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

# Set as default
# xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop

config.load_autoconfig(True)

c.auto_save.session = True
c.input.insert_mode.auto_load = True
c.statusbar.show = "always"  # always, in-mode, never
c.tabs.position = "right"
c.tabs.show = "multiple"
c.tabs.title.format = "{audio} {current_title}"
c.tabs.title.format_pinned = ""
c.url.default_page = "about:blank"
c.url.start_pages = "about:blank"

c.completion.open_categories = [
    "bookmarks",
    "history",
    "quickmarks",
    "filesystem",
    "searchengines",
]

c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "!apkg": "https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=",
    "!aw": "https://wiki.archlinux.org/?search={}",
    "!cr": "https://docs.rs/releases/search?query={}",
    "!gh": "https://github.com/search?o=desc&q={}&s=stars",
    "!pr": "https://www.protondb.com/search?q={}",
    "!rs": "https://doc.rust-lang.org/stable/std/index.html?search={}",
    "!yt": "https://www.youtube.com/results?search_query={}",
}

c.aliases = {
    "h": "help",
    "w": "session-save",
    "q": "close",
    "qa": "quit",
    "wq": "quit --save",
    "wqa": "quit --save",
}

## Bindings
c.bindings.key_mappings = {}
config.unbind("'")
config.unbind("<ctrl-h>")
config.unbind("<ctrl-v>")
config.unbind("ad")

# Global mappings
config.bind("<ctrl-r>", "reload")
config.bind("<ctrl-r>", "reload", mode="insert")
config.bind("<ctrl-r>", "reload", mode="passthrough")
config.bind("<ctrl-w>", "tab-close")
config.bind("<ctrl-w>", "tab-close", mode="insert")
config.bind("<ctrl-w>", "tab-close", mode="passthrough")

# Modes
config.bind(
    "<Escape>", "clear-keychain ;; search ;; fullscreen --leave ;; fake-key <Escape>"
)

config.bind("<ctrl-space>", "mode-enter passthrough")
config.bind("<ctrl-space>", "mode-leave", mode="passthrough")
config.bind("<ctrl-space>", "mode-leave", mode="insert")

# Open in mpv
config.bind("<ctrl-p>", "spawn --detach mpv {url}")
config.bind("<ctrl-p>", "spawn --detach mpv {url}", mode="insert")
config.bind("<ctrl-p>", "spawn --detach mpv {url}", mode="passthrough")

# Normal
config.bind(";", "cmd-set-text :")
config.bind("PP", "open -t -- {clipboard}")
config.bind("U", "undo")
config.bind("d", "scroll-page 0 0.5")
config.bind("u", "scroll-page 0 -0.5")
config.bind(
    "wa", "open -t https://web.archive.org/web/{url}"
)  # web archive of current page


# Bookmarks
config.bind("a", "cmd-set-text :open !")
config.bind("A", "cmd-set-text :open -t !")
config.bind("b", "cmd-set-text -s :quickmark-load -t")
config.bind("D", "bookmark-add")
config.bind("m", "cmd-set-text -s :quickmark-load")
config.bind("M", "quickmark-save")

# Settings
config.bind(
    "sb",
    "config-cycle --print -u {url:host} content.blocking.enabled false true ;; reload",
)
config.bind("sr", "config-cycle tabs.show multiple never")
config.bind(
    "sd",
    "config-cycle --print -u {url:host} colors.webpage.darkmode.enabled false true ;; reload",
)
config.bind("td", "config-cycle --print colors.webpage.darkmode.enabled")
config.bind("sh", "cmd-set-text -s :help -t")
config.bind("sl", "config-cycle tabs.width 300 38")
config.bind("sp", "set --print -u {url:host} input.mode_override passthrough")
config.bind("sP", "config-unset --print -u {url:host} input.mode_override")
config.bind("so", "config-source ;; message-info 'config reloaded'")
config.bind("ss", "config-cycle statusbar.show always never")
config.bind("st", "config-cycle tabs.position top right")
config.bind("sy", "history -t")
config.bind("<alt-b>", "config-cycle tabs.width 300 38")
config.bind("<alt-b>", "config-cycle tabs.width 300 38", mode="passthrough")

# Tabs
config.bind("cc", "tab-clone")
config.bind("x", "tab-close")
config.bind("<backspace>", "tab-focus last")
config.bind("<alt-h>", "tab-prev")
config.bind("<alt-h>", "tab-prev", mode="passthrough")
config.bind("<alt-j>", "tab-move +")
config.bind("<alt-j>", "tab-move +", mode="passthrough")
config.bind("<alt-k>", "tab-move -")
config.bind("<alt-k>", "tab-move -", mode="passthrough")
config.bind("<alt-l>", "tab-next")
config.bind("<alt-l>", "tab-next", mode="passthrough")
config.bind("<alt-p>", "tab-pin")
config.bind("<ctrl-1>", "tab-focus 1")
config.bind("<ctrl-1>", "tab-focus 1", mode="passthrough")
config.bind("<ctrl-2>", "tab-focus 2")
config.bind("<ctrl-2>", "tab-focus 2", mode="passthrough")
config.bind("<ctrl-3>", "tab-focus 3")
config.bind("<ctrl-3>", "tab-focus 3", mode="passthrough")
config.bind("<ctrl-4>", "tab-focus 4")
config.bind("<ctrl-4>", "tab-focus 4", mode="passthrough")
config.bind("<ctrl-5>", "tab-focus 5")
config.bind("<ctrl-5>", "tab-focus 5", mode="passthrough")
config.bind("<ctrl-6>", "tab-focus 6")
config.bind("<ctrl-6>", "tab-focus 6", mode="passthrough")
config.bind("<ctrl-7>", "tab-focus 7")
config.bind("<ctrl-7>", "tab-focus 7", mode="passthrough")
config.bind("<ctrl-8>", "tab-focus 8")
config.bind("<ctrl-8>", "tab-focus 8", mode="passthrough")
config.bind("<ctrl-9>", "tab-focus -1")
config.bind("<ctrl-9>", "tab-focus -1", mode="passthrough")
config.bind("<ctrl-j>", "tab-next")
config.bind("<ctrl-j>", "tab-next", mode="passthrough")
config.bind("<ctrl-k>", "tab-prev")
config.bind("<ctrl-k>", "tab-prev", mode="passthrough")

# Hints
config.bind("'b", "hint all tab-bg")
config.bind("'d", "hint links download")
config.bind("'f", "hint all tab-fg")
config.bind("'h", "hint all hover")
config.bind("'i", "hint images")
config.bind("'I", "hint images tab")
config.bind("'o", "hint links fill :open {hint-url}")
config.bind("'O", "hint links fill :open -t -r {hint-url}")
config.bind("'r", "hint --rapid links tab-bg")
config.bind("'R", "hint --rapid links window")
config.bind("'t", "hint inputs")
config.bind("'y", "hint links yank")
config.bind("'Y", "hint links yank-primary")

# Misc
config.bind("cd", "download-cancel")
config.bind("cl", "download-clear")

## Dark Mode
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.policy.images = "never"
config.set("colors.webpage.darkmode.enabled", False, "file://*")

## UI
# c.content.user_stylesheets = ["~/.config/qutebrowser/styles/youtube-tweaks.css"]
c.tabs.padding = {"top": 5, "bottom": 5, "left": 9, "right": 9}
c.tabs.indicator.width = 0
# c.window.transparent = True  # apparently not needed
c.tabs.width = 38

## Adblock
c.content.blocking.enabled = True
# c.content.blocking.method = 'adblock' # uncomment this if you install python-adblock
# c.content.blocking.adblock.lists = [
#         "https://github.com/ewpratten/youtube_ad_blocklist/blob/master/blocklist.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
#         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt"]


## Colors
# Catppuccin Mocha
palette = {
    "rosewater": "#f5e0dc",
    "flamingo": "#f2cdcd",
    "pink": "#f5c2e7",
    "mauve": "#cba6f7",
    "red": "#f38ba8",
    "maroon": "#eba0ac",
    "peach": "#fab387",
    "yellow": "#f9e2af",
    "green": "#a6e3a1",
    "teal": "#94e2d5",
    "sky": "#89dceb",
    "sapphire": "#74c7ec",
    "blue": "#89b4fa",
    "lavender": "#b4befe",
    "text": "#cdd6f4",
    "subtext1": "#bac2de",
    "subtext0": "#a6adc8",
    "overlay2": "#9399b2",
    "overlay1": "#7f849c",
    "overlay0": "#6c7086",
    "surface2": "#585b70",
    "surface1": "#45475a",
    "surface0": "#313244",
    "base": "#1e1e2e",
    "mantle": "#181825",
    "crust": "#11111b",
}

# completion {{{
## Background color of the completion widget category headers.
c.colors.completion.category.bg = palette["base"]
## Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = palette["mantle"]
## Top border color of the completion widget category headers.
c.colors.completion.category.border.top = palette["overlay2"]
## Foreground color of completion widget category headers.
c.colors.completion.category.fg = palette["green"]
## Background color of the completion widget for even and odd rows.
c.colors.completion.even.bg = palette["mantle"]
c.colors.completion.odd.bg = c.colors.completion.even.bg
## Text color of the completion widget.
c.colors.completion.fg = palette["subtext0"]

## Background color of the selected completion item.
c.colors.completion.item.selected.bg = palette["surface2"]
## Bottom border color of the selected completion item.
c.colors.completion.item.selected.border.bottom = palette["surface2"]
## Top border color of the completion widget category headers.
c.colors.completion.item.selected.border.top = palette["surface2"]
## Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = palette["text"]
## Foreground color of the selected completion item.
c.colors.completion.item.selected.match.fg = palette["rosewater"]
## Foreground color of the matched text in the completion.
c.colors.completion.match.fg = palette["text"]

## Color of the scrollbar in completion view
c.colors.completion.scrollbar.bg = palette["crust"]
## Color of the scrollbar handle in completion view.
c.colors.completion.scrollbar.fg = palette["surface2"]
# }}}

# downloads {{{
c.colors.downloads.bar.bg = palette["base"]
c.colors.downloads.error.bg = palette["base"]
c.colors.downloads.start.bg = palette["base"]
c.colors.downloads.stop.bg = palette["base"]

c.colors.downloads.error.fg = palette["red"]
c.colors.downloads.start.fg = palette["blue"]
c.colors.downloads.stop.fg = palette["green"]
c.colors.downloads.system.fg = "none"
c.colors.downloads.system.bg = "none"
# }}}

# hints {{{
## Background color for hints. Note that you can use a `rgba(...)` value
## for transparency.
c.colors.hints.bg = palette["crust"]

## Font color for hints.
c.colors.hints.fg = palette["green"]

## Hints
c.hints.border = "1px solid " + palette["surface0"]

## Font color for the matched part of hints.
c.colors.hints.match.fg = palette["subtext1"]
# }}}

# keyhints {{{
## Background color of the keyhint widget.
c.colors.keyhint.bg = palette["crust"]

## Text color for the keyhint widget.
c.colors.keyhint.fg = palette["text"]

## Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = palette["subtext1"]
# }}}

# messages {{{
## Background color of an error message.
c.colors.messages.error.bg = palette["crust"]
## Background color of an info message.
c.colors.messages.info.bg = palette["crust"]
## Background color of a warning message.
c.colors.messages.warning.bg = palette["crust"]

## Border color of an error message.
c.colors.messages.error.border = palette["surface0"]
## Border color of an info message.
c.colors.messages.info.border = palette["surface0"]
## Border color of a warning message.
c.colors.messages.warning.border = palette["surface0"]

## Foreground color of an error message.
c.colors.messages.error.fg = palette["red"]
## Foreground color an info message.
c.colors.messages.info.fg = palette["blue"]
## Foreground color a warning message.
c.colors.messages.warning.fg = palette["yellow"]
# }}}

# prompts {{{
## Background color for prompts.
c.colors.prompts.bg = palette["crust"]

# ## Border used around UI elements in prompts.
c.colors.prompts.border = "1px solid " + palette["surface0"]

## Foreground color for prompts.
c.colors.prompts.fg = palette["text"]

## Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = palette["surface2"]

## Background color for the selected item in filename prompts.
c.colors.prompts.selected.fg = palette["rosewater"]
# }}}

# statusbar {{{
## Background color of the statusbar.
c.colors.statusbar.normal.bg = palette["crust"]
## Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = palette["crust"]
## Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = palette["crust"]
## Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = palette["crust"]
## Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = palette["crust"]

## Background color of the progress bar.
c.colors.statusbar.progress.bg = palette["crust"]
## Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = palette["crust"]

## Foreground color of the statusbar.
c.colors.statusbar.normal.fg = palette["text"]
## Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = palette["rosewater"]
## Foreground color of the statusbar in command mode.
c.colors.statusbar.command.fg = palette["text"]
## Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = palette["peach"]
## Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = palette["peach"]
## Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = palette["peach"]

## Foreground color of the URL in the statusbar on error.
c.colors.statusbar.url.error.fg = palette["red"]

## Default foreground color of the URL in the statusbar.
c.colors.statusbar.url.fg = palette["text"]

## Foreground color of the URL in the statusbar for hovered links.
c.colors.statusbar.url.hover.fg = palette["sky"]

## Foreground color of the URL in the statusbar on successful load
c.colors.statusbar.url.success.http.fg = palette["teal"]

## Foreground color of the URL in the statusbar on successful load
c.colors.statusbar.url.success.https.fg = palette["green"]

## Foreground color of the URL in the statusbar when there's a warning.
c.colors.statusbar.url.warn.fg = palette["yellow"]

## PRIVATE MODE COLORS
## Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = "#000000"
## Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = palette["subtext1"]
## Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = palette["base"]
## Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = palette["subtext1"]

# }}}

# tabs {{{
## Background color of the tab bar.
c.colors.tabs.bar.bg = palette["crust"]
## Background color of unselected even tabs.
c.colors.tabs.even.bg = palette["crust"]
c.colors.tabs.pinned.even.bg = palette["crust"]
## Background color of unselected odd tabs.
c.colors.tabs.odd.bg = palette["crust"]
c.colors.tabs.pinned.odd.bg = palette["crust"]

## Foreground color of unselected even tabs.
c.colors.tabs.even.fg = palette["overlay2"]
c.colors.tabs.pinned.even.fg = palette["overlay2"]
## Foreground color of unselected odd tabs.
c.colors.tabs.odd.fg = palette["overlay2"]
c.colors.tabs.pinned.odd.fg = palette["overlay2"]

## Color for the tab indicator on errors.
c.colors.tabs.indicator.error = palette["red"]
## Color gradient interpolation system for the tab indicator.
## Valid values:
##	 - rgb: Interpolate in the RGB color system.
##	 - hsv: Interpolate in the HSV color system.
##	 - hsl: Interpolate in the HSL color system.
##	 - none: Don't show a gradient.
c.colors.tabs.indicator.system = "none"

# ## Background color of selected even tabs.
c.colors.tabs.selected.even.bg = palette["surface0"]
c.colors.tabs.pinned.selected.even.bg = palette["surface0"]
# ## Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = palette["surface0"]
c.colors.tabs.pinned.selected.odd.bg = palette["surface0"]

# ## Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = palette["text"]
c.colors.tabs.pinned.selected.even.fg = palette["text"]
# ## Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = palette["text"]
c.colors.tabs.pinned.selected.odd.fg = palette["text"]
# }}}

# context menus {{{
c.colors.contextmenu.menu.bg = palette["base"]
c.colors.contextmenu.menu.fg = palette["text"]

c.colors.contextmenu.disabled.bg = palette["mantle"]
c.colors.contextmenu.disabled.fg = palette["overlay0"]

c.colors.contextmenu.selected.bg = palette["overlay0"]
c.colors.contextmenu.selected.fg = palette["rosewater"]
# }}}
