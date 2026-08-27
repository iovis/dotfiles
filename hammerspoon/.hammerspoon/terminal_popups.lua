local u = require("utils")

local popups = {
  fn = {
    command = "fn",
    hotkey = { hyper, "o" },
    title = "popup:fn",
    unit = { x = 0.25, y = 0.25, w = 0.5, h = 0.5 },
  },
  powermenu = {
    command = "powermenu",
    hotkey = { hyper, "p" },
    size = { w = 400, h = 200 },
    title = "popup:powermenu",
  },
}

local shell = os.getenv("SHELL") or "/opt/homebrew/bin/fish"
local kitty_windows = hs.window.filter.new("kitty")

local function popup_for_title(title)
  for _, popup in pairs(popups) do
    if popup.title == title then
      return popup
    end
  end
end

local function popup_frame(popup, screen)
  local screen_frame = screen:frame()

  if popup.unit then
    return screen:fromUnitRect(popup.unit)
  end

  return hs.geometry.rect(
    screen_frame.x + (screen_frame.w - popup.size.w) / 2,
    screen_frame.y + (screen_frame.h - popup.size.h) / 2,
    popup.size.w,
    popup.size.h
  )
end

local function report_task_error(action, exit_code, stdout, stderr)
  print(("%s failed with exit code %d\n%s%s"):format(action, exit_code, stdout or "", stderr or ""))
  u.notify(action .. " failed")
end

local function place_popup(window)
  local popup = popup_for_title(window:title())
  if not popup then
    return
  end

  local screen = window:screen()
  if not screen then
    return
  end

  window:setFrame(popup_frame(popup, screen), 0)
  window:focus()
end

kitty_windows:subscribe({
  hs.window.filter.windowCreated,
  hs.window.filter.windowTitleChanged,
}, place_popup)

local function launch(name)
  local popup = assert(popups[name], "Unknown terminal popup: " .. name)
  local focused_window = hs.window.focusedWindow()
  local screen = focused_window and focused_window:screen() or hs.screen.mainScreen()
  local initial_frame = popup_frame(popup, screen)
  local initial_width = math.floor(initial_frame.w + 0.5)
  local initial_height = math.floor(initial_frame.h + 0.5)
  local initial_position = ("%dx%d"):format(math.floor(initial_frame.x + 0.5), math.floor(initial_frame.y + 0.5))

  local arguments = {
    "-n",
    "-a",
    "kitty",
    "--args",
    "--title",
    popup.title,
    "--position",
    initial_position,
    "--override",
    "hide_window_decorations=titlebar-only",
    "--override",
    "macos_quit_when_last_window_closed=yes",
    "--override",
    "window_margin_width=6",
    "--override",
    "placement_strategy=center",
    "--override",
    "remember_window_size=no",
    "--override",
    ("initial_window_width=%d"):format(initial_width),
    "--override",
    ("initial_window_height=%d"):format(initial_height),
    "--override",
    "forward_stdio=yes", -- On macOS, this bypasses /usr/bin/login and avoids its "Last login" banner.
    shell,
    "-c",
    popup.command,
  }

  local task = hs.task.new("/usr/bin/open", function(exit_code, stdout, stderr)
    if exit_code ~= 0 then
      report_task_error("Launching " .. name, exit_code, stdout, stderr)
    end
  end, arguments)

  if not task:start() then
    u.notify("Could not launch " .. name)
  end
end

for name, popup in pairs(popups) do
  hs.hotkey.bind(popup.hotkey[1], popup.hotkey[2], function()
    launch(name)
  end)
end

return {
  launch = launch,
  popups = popups,
}
