-- Based on mpv 0.41.0's player/lua/defaults.lua and Lua scripting manual.
---@meta

---@alias mp.msg.LogLevel
---| 'fatal'
---| 'error'
---| 'warn'
---| 'info'
---| 'v'
---| 'debug'
---| 'trace'

local msg = {}

-- The level parameter is the message priority. It\'s a string and one of
-- `fatal`, `error`, `warn`, `info`, `v`, `debug`, `trace`. The user\'s
-- settings will determine which of these messages will be visible.
-- Normally, all messages are visible, except `v`, `debug` and `trace`.
--
-- The parameters after that are all converted to strings. Spaces are
-- inserted to separate multiple parameters.
--
-- You don\'t need to add newlines.
--
---@param level mp.msg.LogLevel
---@param ... unknown Values are converted to strings before they are logged.
function msg.log(level, ...) end

-- All of these are shortcuts and equivalent to the corresponding
-- `msg.log(level, ...)` call.
--
---@param ... unknown Values are converted to strings before they are logged.
function msg.fatal(...) end

---@param ... unknown Values are converted to strings before they are logged.
function msg.error(...) end

---@param ... unknown Values are converted to strings before they are logged.
function msg.warn(...) end

---@param ... unknown Values are converted to strings before they are logged.
function msg.info(...) end

---@param ... unknown Values are converted to strings before they are logged.
function msg.verbose(...) end

---@param ... unknown Values are converted to strings before they are logged.
function msg.debug(...) end

---@param ... unknown Values are converted to strings before they are logged.
function msg.trace(...) end

return msg
