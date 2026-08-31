local u = require("utils")

local layouts = {
  centered_75 = {
    unit = { x = 0.125, y = 0.125, w = 0.75, h = 0.75 },
  },
  centered_66 = {
    unit = { x = 0.165, y = 0.165, w = 0.66, h = 0.66 },
  },
  centered_50 = {
    unit = { x = 0.25, y = 0.25, w = 0.5, h = 0.5 },
  },
  centered_400x200 = {
    size = { w = 400, h = 200 },
  },
}

local shell = os.getenv("SHELL") or "/opt/homebrew/bin/fish"
local kitty_windows = hs.window.filter.new(false):setAppFilter("kitty", {})
local known_layouts = {}
local layouts_by_title = {}

for _, layout in pairs(layouts) do
  known_layouts[layout] = true
end

local function layout_for_title(title)
  return layouts_by_title[title]
end

local function popup_frame(layout, screen)
  local screen_frame = screen:frame()

  if layout.unit then
    return screen:fromUnitRect(layout.unit)
  end

  return hs.geometry.rect(
    screen_frame.x + (screen_frame.w - layout.size.w) / 2,
    screen_frame.y + (screen_frame.h - layout.size.h) / 2,
    layout.size.w,
    layout.size.h
  )
end

local function report_task_error(action, exit_code, stdout, stderr)
  print(("%s failed with exit code %d\n%s%s"):format(action, exit_code, stdout or "", stderr or ""))
  u.notify(action .. " failed")
end

local function register_title(layout, title)
  assert(known_layouts[layout], "Unknown terminal popup layout")
  assert(type(title) == "string" and title ~= "", "Terminal popup title must be a non-empty string")

  local registered_layout = layouts_by_title[title]
  assert(
    not registered_layout or registered_layout == layout,
    "Terminal popup title is already registered to another layout"
  )
  layouts_by_title[title] = layout
end

local function find_popup(title)
  for _, window in ipairs(kitty_windows:getWindows()) do
    if window:title() == title then
      return window
    end
  end
end

local function focus_popup(window)
  local application = window:application()
  if application and application:isHidden() then
    application:unhide()
  end

  window:unminimize()
  window:focus()
end

local function place_popup(window)
  local layout = layout_for_title(window:title())
  if not layout then
    return
  end

  local screen = window:screen()
  if not screen then
    return
  end

  window:setFrame(popup_frame(layout, screen), 0)
  window:focus()
end

kitty_windows:subscribe({
  hs.window.filter.windowCreated,
  hs.window.filter.windowTitleChanged,
}, place_popup)

local function launch(command, layout, title)
  register_title(layout, title)
  local focused_window = hs.window.focusedWindow()
  local screen = focused_window and focused_window:screen() or hs.screen.mainScreen()
  local initial_frame = popup_frame(layout, screen)
  local initial_width = math.floor(initial_frame.w + 0.5)
  local initial_height = math.floor(initial_frame.h + 0.5)
  local initial_position = ("%dx%d"):format(math.floor(initial_frame.x + 0.5), math.floor(initial_frame.y + 0.5))

  local arguments = {
    "-n",
    "-a",
    "kitty",
    "--args",
    "--title",
    title,
    "--position",
    initial_position,
    "--single-instance",
    "--override",
    "hide_window_decorations=titlebar-only",
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

local function open(command, options)
  assert(type(options) == "table" and options.layout, "Terminal popup options require a layout")
  local title = options.title or ("popup:" .. hs.host.uuid())

  if options.launch_or_focus then
    assert(options.title, "launch_or_focus requires a unique terminal popup title")
    register_title(options.layout, title)

    local window = find_popup(title)
    if window then
      focus_popup(window)
      return
    end
  end

  launch(command, options.layout, title)
end

return {
  layouts = layouts,
  open = open,
}
