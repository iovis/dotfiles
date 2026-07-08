-- Based on mpv 0.41.0's player/lua/input.lua and Lua scripting manual.
---@meta

---@alias mp.input.CompletionCallback fun(text_before_cursor: string): completions: string[]?, start_position: integer?, append: string?

---@class mp.input.GetOptions
---@field prompt? string Text displayed before the input field.
---@field submit? fun(text: string) Called with the entered text when the user presses Enter.
---@field keep_open? boolean Keep the console open after submitting. Defaults to false.
---@field opened? fun() Called when the console is shown.
---@field edited? fun(text: string) Called when the input text changes.
---@field complete? mp.input.CompletionCallback Called with the text before the cursor to provide completion candidates.
---@field autoselect_completion? boolean Select the first completion on submit when none was manually selected. Defaults to false.
---@field closed? fun(text: string, cursor_position: integer) Called when the console is hidden.
---@field default_text? string Text with which to pre-fill the input field.
---@field cursor_position? integer Initial 1-based cursor position.
---@field history_path? string Path at which to save and load entered lines.
---@field id? string Identifier for the input history and log buffer.

---@class mp.input.LogEntry
---@field text string
---@field style? string ASS tags applied to the text when displayed on the OSD.
---@field terminal_style? string Terminal escape sequences applied to the text.

---@alias mp.input.LogLine string|mp.input.LogEntry

---@class mp.input.SelectOptions
---@field prompt? string Text displayed before the input field.
---@field items string[] Entries from which the user can choose.
---@field default_item? integer 1-based index of the initially selected item.
---@field submit? fun(index: integer) Called with the selected item's 1-based index when the user presses Enter.
---@field keep_open? boolean Keep the console open after submitting. Defaults to false.

local input = {}

-- Show the console to let the user enter text.
--
-- The following entries of `options` are read:
--
-- `prompt`
-- The string to be displayed before the input field.
--
-- `submit`
-- A callback invoked when the user presses Enter. The first argument is
-- the text in the console.
--
-- `keep_open`
-- Whether to keep the console open on submit. Defaults to `false`.
--
-- `opened`
-- A callback invoked when the console is shown. This can be used to
-- present a list of options with `input.set_log()`.
--
-- `edited`
-- A callback invoked when the text changes. The first argument is the text
-- in the console.
--
-- `complete`
-- A callback invoked when the user edits the text or moves the cursor. The
-- first argument is the text before the cursor. The callback should return
-- a table of the string candidate completion values and the 1-based cursor
-- position from which the completion starts. console will show the
-- completions that fuzzily match the text between this position and the
-- cursor and allow selecting them.
--
-- The third and optional return value is a string that will be appended to
-- the input line without displaying it in the completions.
--
-- `autoselect_completion`
-- Whether to automatically select the first completion on submit if one
-- wasn't already manually selected. Defaults to `false`.
--
-- `closed`
-- A callback invoked when the console is hidden, either because
-- `input.terminate()` was invoked from the other callbacks, or because
-- the user closed it with a key binding. The first argument is the text in
-- the console, and the second argument is the cursor position.
--
-- `default_text`
-- A string to pre-fill the input field with.
--
-- `cursor_position`
-- The initial cursor position, starting from 1.
--
-- `history_path`
-- If specified, the path to save and load the history of the entered
-- lines.
--
-- `id`
-- An identifier that determines which input history and log buffer to use
-- among the ones stored for `input.get()` calls. Defaults to the calling
-- script name with `prompt` appended.
--
---@param options mp.input.GetOptions
function input.get(options) end

-- Close the console.
--
function input.terminate() end

-- Add a line to the log buffer. `style` can contain additional ASS tags to
-- apply to `message`, and `terminal_style` can contain escape sequences
-- that are used when the console is displayed in the terminal.
--
---@param message string
---@param style? string
---@param terminal_style? string
function input.log(message, style, terminal_style) end

-- Helper to add a line to the log buffer with the same color as the one
-- used for commands that error. Useful when the user submits invalid
-- input.
--
---@param message string
function input.log_error(message) end

-- Replace the entire log buffer.
--
-- `log` is a table of strings, or tables with `text`, `style` and
-- `terminal_style` keys.
--
-- Example:
--
-- ```
-- input.set_log({
--     "regular text",
--     {
--         text = "error text",
--         style = "{\\c&H7a77f2&}",
--         terminal_style = "\027[31m",
--     }
-- })
-- ```
--
---@param log mp.input.LogLine[]
function input.set_log(log) end

-- Specify a list of items that are presented to the user for selection.
--
-- The following entries of `options` are read:
--
-- `prompt`
-- The string to be displayed before the input field.
--
-- `items`
-- The table of the entries to choose from.
--
-- `default_item`
-- The 1-based integer index of the preselected item.
--
-- `submit`
-- The callback invoked when the user presses Enter. The first argument is
-- the 1-based index of the selected item.
--
-- `keep_open`
-- Whether to keep the console open on submit. Defaults to `false`.
--
-- Example:
--
-- > ```
-- > input.select({
-- >     items = {
-- >         "First playlist entry",
-- >         "Second playlist entry",
-- >     },
-- >     submit = function (id)
-- >         mp.commandv("playlist-play-index", id - 1)
-- >     end,
-- > })
-- > ```
--
---@param options mp.input.SelectOptions
function input.select(options) end

return input
