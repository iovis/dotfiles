local u = require("config.utils")

---@class CalendarEvent
---@field title string Title of the event
---@field when string Example: "09:00 - 09:45"
---@field location? string The URL or the physical location of the event

---Get timed events for today
---@return CalendarEvent[]
local function get_calendar_events()
  -- Run calendar command
  local output = u.system_list({
    "icalBuddy",
    "--noCalendarNames",
    "--includeOnlyEventsFromNowOn",
    "--excludeAllDayEvents",
    "--propertyOrder 'datetime,title'",
    "--includeEventProps 'datetime,title,location'",
    "eventsToday",
  })

  -- Parse Events
  local events = {}
  local time_pattern = "^• (.*)"
  local location_pattern = "^location: (.*)"

  if output[1] == "error: No calendars." then
    vim.notify("Error: Calendar not configured", vim.log.levels.ERROR)
    return {}
  end

  for _, line in ipairs(output) do
    line = vim.trim(line)

    if line:match(time_pattern) then
      table.insert(events, { when = line:match(time_pattern):gsub("%s", "") })
    elseif line:match(location_pattern) then
      events[#events].location = line:match(location_pattern)
    else
      events[#events].title = line
    end
  end

  return events
end

local function calendar_picker()
  local events = get_calendar_events()

  if vim.tbl_isempty(events) then
    vim.notify("No events!")
    return
  end

  vim.ui.select(
    events,
    {
      prompt = "events> ",
      ---@param item CalendarEvent
      format_item = function(item)
        local event = ("[%s] %s"):format(item.when, item.title)

        if item.location then
          event = ("%s\t(%s)"):format(event, item.location)
        end

        return event
      end,
    },
    ---@param event? CalendarEvent
    function(event)
      if not event then
        return
      end

      vim.fn.setreg("+", event.title)

      if event.location then
        vim.ui.open(event.location)
      end
    end
  )
end

vim.api.nvim_create_user_command("CalendarPicker", calendar_picker, {})
-- vim.keymap.set("n", "'c", calendar_picker, {
--   desc = "Calendar picker",
-- })
