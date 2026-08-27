local u = require("utils")

local rules = {
  centered_half = {
    title = "popup:centered_half",
    unit = { x = 0.25, y = 0.25, w = 0.5, h = 0.5 },
  },
  centered_400x200 = {
    title = "popup:centered_400x200",
    size = { w = 400, h = 200 },
  },
}

local shell = os.getenv("SHELL") or "/opt/homebrew/bin/fish"
local kitty_windows = hs.window.filter.new("kitty")
local rules_by_title = {}

for _, rule in pairs(rules) do
  rules_by_title[rule.title] = rule
end

local function rule_for_title(title)
  return rules_by_title[title]
end

local function popup_frame(rule, screen)
  local screen_frame = screen:frame()

  if rule.unit then
    return screen:fromUnitRect(rule.unit)
  end

  return hs.geometry.rect(
    screen_frame.x + (screen_frame.w - rule.size.w) / 2,
    screen_frame.y + (screen_frame.h - rule.size.h) / 2,
    rule.size.w,
    rule.size.h
  )
end

local function report_task_error(action, exit_code, stdout, stderr)
  print(("%s failed with exit code %d\n%s%s"):format(action, exit_code, stdout or "", stderr or ""))
  u.notify(action .. " failed")
end

local function place_popup(window)
  local rule = rule_for_title(window:title())
  if not rule then
    return
  end

  local screen = window:screen()
  if not screen then
    return
  end

  window:setFrame(popup_frame(rule, screen), 0)
  window:focus()
end

kitty_windows:subscribe({
  hs.window.filter.windowCreated,
  hs.window.filter.windowTitleChanged,
}, place_popup)

local function launch(rule, command)
  assert(rule and rule.title and rules_by_title[rule.title] == rule, "Unknown terminal popup rule")
  local focused_window = hs.window.focusedWindow()
  local screen = focused_window and focused_window:screen() or hs.screen.mainScreen()
  local initial_frame = popup_frame(rule, screen)
  local initial_width = math.floor(initial_frame.w + 0.5)
  local initial_height = math.floor(initial_frame.h + 0.5)
  local initial_position = ("%dx%d"):format(math.floor(initial_frame.x + 0.5), math.floor(initial_frame.y + 0.5))

  local arguments = {
    "-n",
    "-a",
    "kitty",
    "--args",
    "--title",
    rule.title,
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
    command,
  }

  local task = hs.task.new("/usr/bin/open", function(exit_code, stdout, stderr)
    if exit_code ~= 0 then
      report_task_error("Launching terminal popup", exit_code, stdout, stderr)
    end
  end, arguments)

  if not task:start() then
    u.notify("Could not launch terminal popup")
  end
end

return {
  launch = launch,
  rules = rules,
}
