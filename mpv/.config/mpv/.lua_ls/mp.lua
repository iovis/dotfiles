-- Based on mpv 0.41.0's Lua API documentation and player/lua/defaults.lua.
---@meta

---@class mp
---@field script_name string
---@field keep_running boolean
---@field use_suspend boolean Deprecated and ignored by mpv 0.41.
---@field UNKNOWN_TYPE table
---@field ARRAY table
---@field MAP table
mp = mp

---@alias mp.LogLevel
---| "no"
---| "fatal"
---| "error"
---| "warn"
---| "info"
---| "status"
---| "v"
---| "debug"
---| "trace"

---@alias mp.PropertyFormat
---| "none"
---| "native"
---| "bool"
---| "string"
---| "number"

---@alias mp.KeyEventType
---| "down"
---| "repeat"
---| "up"
---| "press"
---| "unknown"

---@class mp.KeyEvent
---@field event mp.KeyEventType
---@field is_mouse boolean
---@field canceled? boolean
---@field key_name? string
---@field key_text? string
---@field scale? number
---@field arg? string

---@alias mp.KeyBindingCallback fun(event?: mp.KeyEvent)

---@class mp.KeyBindingFlags
---@field repeatable? boolean
---@field scalable? boolean
---@field complex? boolean

---@class mp.Event
---@field event string
---@field name string
---@field error? string
---@field [string] any

---@alias mp.EventCallback fun(event: mp.Event)
---@alias mp.PropertyObserver fun(name: string, value?: any)

---@class mp.Timer
---@field timeout number
---@field oneshot boolean
---@field cb fun()
---@field next_deadline? number
---@field stop fun(self: mp.Timer)
---@field kill fun(self: mp.Timer)
---@field resume fun(self: mp.Timer)
---@field is_enabled fun(self: mp.Timer): boolean

---@class mp.AsyncCommand
---@field id? integer
---@field cb fun(success: boolean, result: any, error: string?)

---@class mp.OsdOverlayBounds
---@field x0? number
---@field y0? number
---@field x1? number
---@field y1? number

---@class mp.OsdOverlay
---@field format "ass-events"|"none"
---@field id integer
---@field data string
---@field res_x number
---@field res_y number
---@field z? integer
---@field hidden? boolean
---@field compute_bounds? boolean
---@field update fun(self: mp.OsdOverlay): mp.OsdOverlayBounds?, string?
---@field remove fun(self: mp.OsdOverlay)

---@class mp.Hook
---@field defer fun(self: mp.Hook)
---@field cont fun(self: mp.Hook)

---@class mp.LegacyKeyBinding
---@field [1] string key
---@field [2]? string|fun() command or press callback
---@field [3]? fun() key-down callback
---@field [4]? fun() key-up callback

-- ## Details on the script initialization and lifecycle
--
-- Your script will be loaded by the player at program start from the
-- `scripts` configuration subdirectory, or from a path specified with the
-- `--script` option. Some scripts are loaded internally (like `--osc`).
-- Each script runs in its own thread. Your script is first run \"as is\",
-- and once that is done, the event loop is entered. This event loop will
-- dispatch events received by mpv and call your own event handlers which
-- you have registered with `mp.register_event`, or timers added with
-- `mp.add_timeout` or similar. Note that since the script starts execution
-- concurrently with player initialization, some properties may not be
-- populated with meaningful values until the relevant subsystems have
-- initialized. Rather than retrieving these properties at the top of
-- scripts, you should use `mp.observe_property` or read them within event
-- handlers.
--
-- When the player quits, all scripts will be asked to terminate. This
-- happens via a `shutdown` event, which by default will make the event
-- loop return. If your script got into an endless loop, mpv will probably
-- behave fine during playback, but it won\'t terminate when quitting,
-- because it\'s waiting on your script.
--
-- Internally, the C code will call the Lua function `mp_event_loop` after
-- loading a Lua script. This function is normally defined by the default
-- prelude loaded before your script (see `player/lua/defaults.lua` in the
-- mpv sources). The event loop will wait for events and dispatch events
-- registered with `mp.register_event`. It will also handle timers added
-- with `mp.add_timeout` and similar (by waiting with a timeout).
--
-- Since mpv 0.6.0, the player will wait until the script is fully loaded
-- before continuing normal operation. The player considers a script as
-- fully loaded as soon as it starts waiting for mpv events (or it exits).
-- In practice this means the player will more or less hang until the
-- script returns from the main chunk (and `mp_event_loop` is called), or
-- the script calls `mp_event_loop` or `mp.dispatch_events` directly. This
-- is done to make it possible for a script to fully setup event handlers
-- etc. before playback actually starts. In older mpv versions, this
-- happened asynchronously. With mpv 0.29.0, this changes slightly, and it
-- merely waits for scripts to be loaded in this manner before starting
-- playback as part of the player initialization phase. Scripts run though
-- initialization in parallel. This might change again.
--
-- Run the given command. This is similar to the commands used in
-- input.conf. See [List of Input
-- Commands](https://mpv.io/manual/stable/#list-of-input-commands).
--
-- By default, this will show something on the OSD (depending on the
-- command), as if it was used in `input.conf`. See [Input Command
-- Prefixes](https://mpv.io/manual/stable/#input-command-prefixes) how to
-- influence OSD usage per command.
--
-- Returns `true` on success, or `nil, error` on error.
--
---@param command string
---@return true? success
---@return string? error
function mp.command(command) end

-- Similar to `mp.command`, but pass each command argument as separate
-- parameter. This has the advantage that you don\'t have to care about
-- quoting and escaping in some cases.
--
-- Example:
--
-- ```
-- mp.command("loadfile " .. filename .. " append")
-- mp.commandv("loadfile", filename, "append")
-- ```
--
-- These two commands are equivalent, except that the first version breaks
-- if the filename contains spaces or certain special characters.
--
-- Note that properties are *not* expanded. You can use either
-- `mp.command`, the `expand-properties` prefix, or the `mp.get_property`
-- family of functions.
--
-- Unlike `mp.command`, this will not use OSD by default either (except for
-- some OSD-specific commands).
--
---@param arg1 string|number
---@param arg2? string|number
---@param ... string|number
---@return true? success
---@return string? error
function mp.commandv(arg1, arg2, ...) end

-- Similar to `mp.commandv`, but pass the argument list as table. This has
-- the advantage that in at least some cases, arguments can be passed as
-- native types. It also allows you to use named argument.
--
-- If the table is an array, each array item is like an argument in
---@param command table
---@param default? any
---@return any result
---@return string? error
function mp.command_native(command, default) end

--
-- If the table contains string keys, it\'s interpreted as command with
-- named arguments. This requires at least an entry with the key `name` to
-- be present, which must be a string, and contains the command name. The
-- special entry `_flags` is optional, and if present, must be an array of
-- [Input Command
-- Prefixes](https://mpv.io/manual/stable/#input-command-prefixes) to
-- apply. All other entries are interpreted as arguments.
--
-- Returns a result table on success (usually empty), or `def, error` on
-- error. `def` is the second parameter provided to the function, and is
-- nil if it\'s missing.
-- Like `mp.command_native()`, but the command is ran asynchronously (as
-- far as possible), and upon completion, fn is called. fn has three
-- arguments: `fn(success, result, error)`:
--
-- > `success`
-- > Always a Boolean and is true if the command was successful, otherwise
-- > false.
-- >
-- > `result`
-- > The result value (can be nil) in case of success, nil otherwise (as
-- > returned by `mp.command_native()`).
-- >
-- > `error`
-- > The error string in case of an error, nil otherwise.
--
-- Returns a table with undefined contents, which can be used as argument
-- for `mp.abort_async_command`.
--
-- If starting the command failed for some reason, `nil, error` is
-- returned, and `fn` is called indicating failure, using the same error
-- value.
--
-- `fn` is always called asynchronously, even if the command failed to
-- start.
--
---@param command table
---@param callback? fun(success: boolean, result: any, error: string?)
---@return mp.AsyncCommand? handle
---@return string? error
function mp.command_native_async(command, callback) end

-- Abort a `mp.command_native_async` call. The argument is the return value
-- of that command (which starts asynchronous execution of the command).
-- Whether this works and how long it takes depends on the command and the
-- situation. The abort call itself is asynchronous. Does not return
-- anything.
--
---@param handle mp.AsyncCommand
function mp.abort_async_command(handle) end

-- Delete the given property. See `mp.get_property` and
-- [Properties](https://mpv.io/manual/stable/#properties) for more
-- information about properties. Most properties cannot be deleted.
--
-- Returns true on success, or `nil, error` on error.
--
---@param name string
---@return true? success
---@return string? error
function mp.del_property(name) end

-- Return the value of the given property as string. These are the same
-- properties as used in input.conf. See
-- [Properties](https://mpv.io/manual/stable/#properties) for a list of
-- properties. The returned string is formatted similar to `${=name}` (see
-- [Property Expansion](https://mpv.io/manual/stable/#property-expansion)).
--
-- Returns the string on success, or `def, error` on error. `def` is the
-- second parameter provided to the function, and is nil if it\'s missing.
--
---@param name string
---@param default? string
---@return string? value
---@return string? error
function mp.get_property(name, default) end

-- Similar to `mp.get_property`, but return the property value formatted
-- for OSD. This is the same string as printed with `${name}` when used in
-- input.conf.
--
-- Returns the string on success, or `def, error` on error. `def` is the
-- second parameter provided to the function, and is an empty string if
-- it\'s missing. Unlike `get_property()`, assigning the return value to a
-- variable will always result in a string.
--
---@param name string
---@param default? string
---@return string value
---@return string? error
function mp.get_property_osd(name, default) end

-- Similar to `mp.get_property`, but return the property value as Boolean.
--
-- Returns a Boolean on success, or `def, error` on error.
--
---@param name string
---@param default? boolean
---@return boolean? value
---@return string? error
function mp.get_property_bool(name, default) end

-- Similar to `mp.get_property`, but return the property value as number.
--
-- Note that while Lua does not distinguish between integers and floats,
-- mpv internals do. This function simply request a double float from mpv,
-- and mpv will usually convert integer property values to float.
--
-- Returns a number on success, or `def, error` on error.
--
---@param name string
---@param default? number
---@return number? value
---@return string? error
function mp.get_property_number(name, default) end

-- Similar to `mp.get_property`, but return the property value using the
-- best Lua type for the property. Most time, this will return a string,
-- Boolean, or number. Some properties (for example `chapter-list`) are
-- returned as tables.
--
-- Returns a value on success, or `def, error` on error. Note that `nil`
-- might be a possible, valid value too in some corner cases.
--
---@param name string
---@param default? any
---@return any value
---@return string? error
function mp.get_property_native(name, default) end

-- Set the given property to the given string value. See `mp.get_property`
-- and [Properties](https://mpv.io/manual/stable/#properties) for more
-- information about properties.
--
-- Returns true on success, or `nil, error` on error.
--
---@param name string
---@param value string|number Values accepted by Lua's string conversion.
---@return true? success
---@return string? error
function mp.set_property(name, value) end

-- Similar to `mp.set_property`, but set the given property to the given
-- Boolean value.
--
---@param name string
---@param value boolean
---@return true? success
---@return string? error
function mp.set_property_bool(name, value) end

-- Similar to `mp.set_property`, but set the given property to the given
-- numeric value.
--
-- Note that while Lua does not distinguish between integers and floats,
-- mpv internals do. This function will test whether the number can be
-- represented as integer, and if so, it will pass an integer value to mpv,
-- otherwise a double float.
--
---@param name string
---@param value number
---@return true? success
---@return string? error
function mp.set_property_number(name, value) end

-- Similar to `mp.set_property`, but set the given property using its
-- native type.
--
-- Since there are several data types which cannot represented natively in
-- Lua, this might not always work as expected. For example, while the Lua
-- wrapper can do some guesswork to decide whether a Lua table is an array
-- or a map, this would fail with empty tables. Also, there are not many
-- properties for which it makes sense to use this, instead of
-- `set_property`, `set_property_bool`, `set_property_number`. For these
-- reasons, this function should probably be avoided for now, except for
-- properties that use tables natively.
--
---@param name string
---@param value any
---@return true? success
---@return string? error
function mp.set_property_native(name, value) end

-- Return the current mpv internal time in seconds as a number. This is
-- basically the system time, with an arbitrary offset.
--
---@return number seconds
function mp.get_time() end

-- Write a message using mpv's logging system. Prefer `mp.msg` for the
-- convenience methods associated with each level.
---@param level mp.LogLevel
---@param ... unknown Values are converted to strings before they are logged.
function mp.log(level, ...) end

-- Resolve a path relative to mpv's configuration search directories.
---@param path string
---@return string? resolved_path
function mp.find_config_file(path) end

-- Format a time value using mpv's strftime-like time format syntax.
---@param seconds number
---@param format? string Defaults to `%H:%M:%S`.
---@return string formatted
function mp.format_time(seconds, format) end

-- Return the current mouse position in OSD coordinates.
---@return number x
---@return number y
function mp.get_mouse_pos() end

-- Define and control an input section. These are low-level helpers used by
-- the legacy key-binding API.
---@param section string
---@param contents string
---@param flags? string
function mp.input_define_section(section, contents, flags) end

---@param section string
---@param flags? string
function mp.input_enable_section(section, flags) end

---@param section string
function mp.input_disable_section(section) end

-- Replace all bindings previously installed through this legacy API.
---@param bindings mp.LegacyKeyBinding[]
---@param section? string
---@param flags? string
function mp.set_key_bindings(bindings, section, flags) end

---@param section? string
---@param flags? string
function mp.enable_key_bindings(section, flags) end

---@param section? string
function mp.disable_key_bindings(section) end

---@param x0 integer
---@param y0 integer
---@param x1 integer
---@param y1 integer
---@param section? string
function mp.set_mouse_area(x0, y0, x1, y1, section) end

-- Apply pending bindings registered through the newer key-binding API. mpv
-- normally calls this automatically from an idle handler.
function mp.flush_keybindings() end

-- Register callback to be run on a key binding. The binding will be mapped
-- to the given `key`, which is a string describing the physical key. This
-- uses the same key names as in input.conf, and also allows combinations
-- (e.g. `ctrl+a`). If the key is empty or `nil`, no physical key is
-- registered, but the user still can create own bindings (see below).
--
-- After calling this function, key presses will cause the function `fn` to
-- be called (unless the user remapped the key with another binding).
-- However, if the key binding is canceled , the function will not be
-- called, unless `complex` flag is set to `true`, where the function will
-- be called with the `canceled` entry set to `true`.
--
-- For example, a canceled key binding can happen in the following
-- situations:
--
-- - If key A is pressed while key B is being held down, key B is logically
--   released (\"canceled\" by key A), which stops the current autorepeat
--   action key B has.
-- - If key A is pressed while a mouse button is being held down, the mouse
--   button is logically released, but the mouse button\'s action will not
--   be called, unless `complex` flag is set to `true`.
--
-- The `name` argument should be a short symbolic string. It allows the
-- user to remap the key binding via input.conf using the `script-message`
-- command, and the name of the key binding (see below for an example). The
-- name should be unique across other bindings in the same script - if not,
-- the previous binding with the same name will be overwritten. You can
-- omit the name, in which case a random name is generated internally.
-- (Omitting works as follows: either pass `nil` for `name`, or pass the
-- `fn` argument in place of the name. The latter is not recommended and is
-- handled for compatibility only.)
--
-- The `flags` argument is used for optional parameters. This is a table,
-- which can have the following entries:
--
-- > `repeatable`
-- > If set to `true`, enables key repeat for this specific binding. This
-- > option only makes sense when `complex` is not set to `true`.
-- >
-- > `scalable`
-- > If set to `true`, enables key scaling for this specific binding. This
-- > option only makes sense when `complex` is set to `true`. Note that
-- > this has no effect if the key binding is invoked by `script-binding`
-- > command, where the scalability of the command takes precedence.
-- >
-- > `complex`
-- > If set to `true`, then `fn` is called on key down, repeat and up
-- > events, with the first argument being a table. This table has the
-- > following entries (and may contain undocumented ones):
-- >
-- > > `event`
-- > > Set to one of the strings `down`, `repeat`, `up` or `press` (the
-- > > latter if key up/down/repeat can\'t be tracked), which indicates the
-- > > key\'s logical state.
-- > >
-- > > `is_mouse`
-- > > Boolean: Whether the event was caused by a mouse button.
-- > >
-- > > `canceled`
-- > > Boolean: Whether the event was canceled. Not all types of
-- > > cancellations set this flag.
-- > >
-- > > `key_name`
-- > > The name of they key that triggered this, or `nil` if invoked
-- > > artificially. If the key name is unknown, it\'s an empty string.
-- > >
-- > > `key_text`
-- > > Text if triggered by a text key, otherwise `nil`. See description of
-- > > `script-binding` command for details (this field is equivalent to
-- > > the 5th argument).
-- > >
-- > > `scale`
-- > > The scale of the key, such as the ones produced by `WHEEL_*` keys.
-- > > The scale is 1 if the key is nonscalable.
-- > >
-- > > `arg`
-- > > User-provided string in the `arg` argument in the `script-binding`
-- > > command if the key binding is invoked by that command.
--
-- Internally, key bindings are dispatched via the `script-message-to` or
-- `script-binding` input commands and `mp.register_script_message`.
--
-- Trying to map multiple commands to a key will essentially prefer a
-- random binding, while the other bindings are not called. It is
-- guaranteed that user defined bindings in the central input.conf are
-- preferred over bindings added with this function (but see
-- `mp.add_forced_key_binding`).
--
-- Example:
--
-- ```
-- function something_handler()
--     print("the key was pressed")
-- end
-- mp.add_key_binding("x", "something", something_handler)
-- ```
--
-- This will print the message `the key was pressed` when `x` was pressed.
--
-- The user can remap these key bindings. Then the user has to put the
-- following into their input.conf to remap the command to the `y` key:
--
-- ```
-- y script-binding something
-- ```
--
-- This will print the message when the key `y` is pressed. (`x` will still
-- work, unless the user remaps it.)
--
-- You can also explicitly send a message to a named script only. Assume
-- the above script was using the filename `fooscript.lua`:
--
-- ```
-- y script-binding fooscript/something
-- ```
--
---@param key string?
---@param name string?
---@param fn mp.KeyBindingCallback
---@param flags? mp.KeyBindingFlags|"repeatable"|"scalable"
---@overload fun(key: string?, fn: mp.KeyBindingCallback, flags?: mp.KeyBindingFlags|"repeatable"|"scalable")
function mp.add_key_binding(key, name, fn, flags) end

-- This works almost the same as `mp.add_key_binding`, but registers the
-- key binding in a way that will overwrite the user\'s custom bindings in
-- their input.conf. (`mp.add_key_binding` overwrites default key bindings
-- only, but not those by the user\'s input.conf.)
--
---@param key string?
---@param name string?
---@param fn mp.KeyBindingCallback
---@param flags? mp.KeyBindingFlags|"repeatable"|"scalable"
---@overload fun(key: string?, fn: mp.KeyBindingCallback, flags?: mp.KeyBindingFlags|"repeatable"|"scalable")
function mp.add_forced_key_binding(key, name, fn, flags) end

-- Remove a key binding added with `mp.add_key_binding` or
-- `mp.add_forced_key_binding`. Use the same name as you used when adding
-- the bindings. It\'s not possible to remove bindings for which you
-- omitted the name.
--
---@param name string
function mp.remove_key_binding(name) end

-- Call a specific function when an event happens. The event name is a
-- string, and the function fn is a Lua function value.
--
-- Some events have associated data. This is put into a Lua table and
-- passed as argument to fn. The Lua table by default contains a `name`
-- field, which is a string containing the event name. If the event has an
-- error associated, the `error` field is set to a string describing the
-- error, on success it\'s not set.
--
-- If multiple functions are registered for the same event, they are run in
-- registration order, which the first registered function running before
-- all the other ones.
--
-- Returns true if such an event exists, false otherwise.
--
-- See [Events](https://mpv.io/manual/stable/#events) and [List of
-- events](https://mpv.io/manual/stable/#list-of-events) for details.
--
---@param name string
---@param callback mp.EventCallback
---@return boolean supported
function mp.register_event(name, callback) end

-- Undo `mp.register_event(..., fn)`. This removes all event handlers that
-- are equal to the `fn` parameter. This uses normal Lua `==` comparison,
-- so be careful when dealing with closures.
--
---@param callback mp.EventCallback
function mp.unregister_event(callback) end

-- Watch a property for changes. If the property `name` is changed, then
-- the function `fn(name)` will be called. `type` can be `nil`, or be set
-- to one of `none`, `native`, `bool`, `string`, or `number`. `none` is the
-- same as `nil`. For all other values, the new value of the property will
-- be passed as second argument to `fn`, using `mp.get_property_<type>` to
-- retrieve it. This means if `type` is for example `string`, `fn` is
-- roughly called as in `fn(name, mp.get_property(name))`.
--
-- If possible, change events are coalesced. If a property is changed a
-- bunch of times in a row, only the last change triggers the change
-- function. (The exact behavior depends on timing and other things.)
--
-- If a property is unavailable, or on error, the value argument to `fn` is
-- `nil`. (The `observe_property()` call always succeeds, even if a
-- property does not exist.)
--
-- In some cases the function is not called even if the property changes.
-- This depends on the property, and it\'s a valid feature request to ask
-- for better update handling of a specific property.
--
-- If the `type` is `none` or `nil`, the change function `fn` will be
-- called sporadically even if the property doesn\'t actually change. You
-- should therefore avoid using these types.
--
-- You always get an initial change notification. This is meant to
-- initialize the user\'s state to the current value of the property.
--
---@param name string
---@param format? mp.PropertyFormat
---@param callback mp.PropertyObserver
function mp.observe_property(name, format, callback) end

-- Undo `mp.observe_property(..., fn)`. This removes all property handlers
-- that are equal to the `fn` parameter. This uses normal Lua `==`
-- comparison, so be careful when dealing with closures.
--
---@param callback mp.PropertyObserver
function mp.unobserve_property(callback) end

-- Call the given function fn when the given number of seconds has elapsed.
-- Note that the number of seconds can be fractional. For now, the timer\'s
-- resolution may be as low as 50 ms, although this will be improved in the
-- future.
--
-- If the `disabled` argument is set to `true` or a truthy value, the timer
-- will wait to be manually started with a call to its `resume()` method.
--
-- This is a one-shot timer: it will be removed when it\'s fired.
--
-- Returns a timer object. See `mp.add_periodic_timer` for details.
--
---@param seconds number
---@param callback fun()
---@param disabled? boolean
---@return mp.Timer timer
function mp.add_timeout(seconds, callback, disabled) end

-- Call the given function periodically. This is like `mp.add_timeout`, but
-- the timer is re-added after the function fn is run.
--
-- Returns a timer object. The timer object provides the following methods:
--
-- > `stop()`
-- > Disable the timer. Does nothing if the timer is already disabled. This
-- > will remember the current elapsed time when stopping, so that
-- > `resume()` essentially unpauses the timer.
-- >
-- > `kill()`
-- > Disable the timer. Resets the elapsed time. `resume()` will restart
-- > the timer.
-- >
-- > `resume()`
-- > Restart the timer. If the timer was disabled with `stop()`, this will
-- > resume at the time it was stopped. If the timer was disabled with
-- > `kill()`, or if it\'s a previously fired one-shot timer (added with
-- > `add_timeout()`), this starts the timer from the beginning, using the
-- > initially configured timeout.
-- >
-- > `is_enabled()`
-- > Whether the timer is currently enabled or was previously disabled
-- > (e.g. by `stop()` or `kill()`).
-- >
-- > `timeout` (RW)
-- > This field contains the current timeout period. This value is not
-- > updated as time progresses. It\'s only used to calculate when the
-- > timer should fire next when the timer expires.
-- >
-- > If you write this, you can call `t:kill() ; t:resume()` to reset the
-- > current timeout to the new one. (`t:stop()` won\'t use the new
-- > timeout.)
-- >
-- > `oneshot` (RW)
-- > Whether the timer is periodic (`false`) or fires just once (`true`).
-- > This value is used when the timer expires (but before the timer
-- > callback function fn is run).
--
-- Note that these are methods, and you have to call them using `:` instead
-- of `.` (Refer to <https://www.lua.org/manual/5.2/manual.html#3.4.9> .)
--
-- Example:
--
-- ```
-- seconds = 0
-- timer = mp.add_periodic_timer(1, function()
--     print("called every second")
--     -- stop it after 10 seconds
--     seconds = seconds + 1
--     if seconds >= 10 then
--         timer:kill()
--     end
-- end)
-- ```
--
---@param seconds number
---@param callback fun()
---@param disabled? boolean
---@return mp.Timer timer
function mp.add_periodic_timer(seconds, callback, disabled) end

-- Disable a timer and reset its elapsed time. This is the function form of
-- `timer:kill()` retained for compatibility with older scripts.
---@param timer mp.Timer
function mp.cancel_timer(timer) end

-- Return a setting from the `--script-opts` option. It\'s up to the user
-- and the script how this mechanism is used. Currently, all scripts can
-- access this equally, so you should be careful about collisions.
--
---@generic T
---@param key string
---@param default? T
---@return string|T|nil value
function mp.get_opt(key, default) end

-- Return the name of the current script. The name is usually made of the
-- filename of the script, with directory and file extension removed. If
-- there are several scripts which would have the same name, it\'s made
-- unique by appending a number. Any nonalphanumeric characters are
-- replaced with `_`.
--
-- ::: admonition
-- Example
--
-- The script `/path/to/foo-script.lua` becomes `foo_script`.
-- :::
--
---@return string name
function mp.get_script_name() end

-- Return the directory if this is a script packaged as directory (see
-- [Script location](https://mpv.io/manual/stable/#script-location) for a
-- description). Return nothing if this is a single file script.
--
---@return string? directory
function mp.get_script_directory() end

-- Show an OSD message on the screen. `duration` is in seconds, and is
-- optional (uses `--osd-duration` by default).
--
---@param text string
---@param duration? number
function mp.osd_message(text, duration) end

-- Calls `mpv_get_wakeup_pipe()` and returns the read end of the wakeup
-- pipe. This is deprecated, but still works. (See `client.h` for details.)
--
---@return integer file_descriptor
function mp.get_wakeup_pipe() end

-- Return the relative time in seconds when the next timer
-- (`mp.add_timeout` and similar) expires. If there is no timer, return
-- `nil`.
--
---@return number? seconds
function mp.get_next_timeout() end

-- Wait for the next raw mpv event, or until the timeout expires. This is an
-- implementation-exposed helper used by the default event loop.
---@param timeout? number
---@return mp.Event event
function mp.wait_event(timeout) end

-- This can be used to run custom event loops. If you want to have direct
-- control what the Lua script does (instead of being called by the default
-- event loop), you can set the global variable `mp_event_loop` to your own
-- function running the event loop. From your event loop, you should call
---@param allow_wait? boolean
function mp.dispatch_events(allow_wait) end

--
-- If the `allow_wait` parameter is set to `true`, the function will block
-- until the next event is received or the next timer expires. Otherwise
-- (and this is the default behavior), it returns as soon as the event loop
-- is emptied. It\'s strongly recommended to use `mp.get_next_timeout()`
-- and `mp.get_wakeup_pipe()` if you\'re interested in properly working
-- notification of new events and working timers.
-- Register an event loop idle handler. Idle handlers are called before the
-- script goes to sleep after handling all new events. This can be used for
-- example to delay processing of property change events: if you\'re
-- observing multiple properties at once, you might not want to act on each
-- property change, but only when all change notifications have been
-- received.
--
---@param callback fun()
function mp.register_idle(callback) end

-- Undo `mp.register_idle(fn)`. This removes all idle handlers that are
-- equal to the `fn` parameter. This uses normal Lua `==` comparison, so be
-- careful when dealing with closures.
--
---@param callback fun()
function mp.unregister_idle(callback) end

-- Set the minimum log level of which mpv message output to receive. These
-- messages are normally printed to the terminal. By calling this function,
-- you can set the minimum log level of messages which should be received
-- with the `log-message` event. See the description of this event for
-- details. The level is a string, see `msg.log` for allowed log levels.
--
---@param level mp.LogLevel
---@return true? success
---@return string? error
function mp.enable_messages(level) end

-- This is a helper to dispatch `script-message` or `script-message-to`
-- invocations to Lua functions. `fn` is called if `script-message` or
-- `script-message-to` (with this script as destination) is run with `name`
-- as first parameter. The other parameters are passed to `fn`. If a
-- message with the given name is already registered, it\'s overwritten.
--
-- Used by `mp.add_key_binding`, so be careful about name collisions.
--
---@param name string
---@param callback fun(...: string)
function mp.register_script_message(name, callback) end

-- Undo a previous registration with `mp.register_script_message`. Does
-- nothing if the `name` wasn\'t registered.
--
---@param name string
function mp.unregister_script_message(name) end

-- Create an OSD overlay. This is a very thin wrapper around the
-- `osd-overlay` command. The function returns a table, which mostly
-- contains fields that will be passed to `osd-overlay`. The `format`
-- parameter is used to initialize the `format` field. The `data` field
-- contains the text to be used as overlay. For details, see the
-- `osd-overlay` command.
--
-- In addition, it provides the following methods:
--
---@param format "ass-events"|"none"
---@return mp.OsdOverlay overlay
function mp.create_osd_overlay(format) end

-- Set an ASS overlay through the legacy single-overlay helper.
---@param res_x number
---@param res_y number
---@param data string
function mp.set_osd_ass(res_x, res_y, data) end

-- Commit the OSD overlay to the screen, or in other words, run the
-- `osd-overlay` command with the current fields of the overlay table.
-- Returns the result of the `osd-overlay` command itself.
--
-- Remove the overlay from the screen. A `update()` call will add it again.
--
-- Example:
--
-- ```
-- ov = mp.create_osd_overlay("ass-events")
-- ov.data = "{\\an5}{\\b1}hello world!"
-- ov:update()
-- ```
--
-- The advantage of using this wrapper (as opposed to running `osd-overlay`
-- directly) is that the `id` field is allocated automatically.
--
-- Returns a tuple of `osd_width, osd_height, osd_par`. The first two give
-- the size of the OSD in pixels (for video outputs like `--vo=xv`, this
-- may be \"scaled\" pixels). The third is the display pixel aspect ratio.
--
-- May return invalid/nonsense values if OSD is not initialized yet.
--
---@return number width
---@return number height
---@return number pixel_aspect
function mp.get_osd_size() end

-- Return the OSD margins as left, top, right, and bottom values.
---@return number left
---@return number top
---@return number right
---@return number bottom
function mp.get_osd_margins() end

-- Make the script exit at the end of the current event loop iteration.
-- This does not terminate mpv itself or other scripts.
--
-- This can be polyfilled to support mpv versions older than 0.40 with:
--
-- ```
-- if not _G.exit then
--     function exit()
--         mp.keep_running = false
--     end
-- end
-- ```
--
function exit() end

-- Add a hook callback for `type` (a string identifying a certain kind of
-- hook). These hooks allow the player to call script functions and wait
-- for their result (normally, the Lua scripting interface is asynchronous
-- from the point of view of the player core). `priority` is an arbitrary
-- integer that allows ordering among hooks of the same kind. Using the
-- value 50 is recommended as neutral default value.
--
---@param name string
---@param priority integer
---@param callback fun(hook: mp.Hook)
function mp.add_hook(name, priority, callback) end

-- hook. The parameter passed to it (`hook`) is a Lua object that can
-- control further aspects about the currently invoked hook. It provides
-- the following methods:
--
-- > `defer()`
-- > Returning from the hook function should not automatically continue the
-- > hook. Instead, the API user wants to call `hook:cont()` on its own at
-- > a later point in time (before or after the function has returned).
-- >
-- > `cont()`
-- > Continue the hook. Doesn\'t need to be called unless `defer()` was
-- > called.
--
-- See [Hooks](https://mpv.io/manual/stable/#hooks) for currently existing
-- hooks and what they do - only the hook list is interesting; handling
-- hook execution is done by the Lua script function automatically.

return mp
