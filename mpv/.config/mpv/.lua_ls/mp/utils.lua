---@meta

local utils = {}

---@alias mp.utils.Path string
---@alias mp.utils.ReaddirFilter
---| "files"  # Regular files and symlinks to regular files.
---| "dirs"   # Directories and symlinks to directories.
---| "normal" # Regular files and directories (the default).
---| "all"    # All directory entries, including `.` and `..`.

---@class mp.utils.FileInfo
---@field mode integer Protection bits.
---@field size integer Size in bytes.
---@field atime integer Last access time as Unix time.
---@field mtime integer Last modification time as Unix time.
---@field ctime integer Last metadata change time as Unix time.
---@field is_file boolean Whether the path is a regular file.
---@field is_dir boolean Whether the path is a directory.

---@alias mp.utils.Environment string[] # Entries in `NAME=VALUE` form.

---@class mp.utils.SubprocessOptions
---@field args string[] Executable followed by its arguments.
---@field playback_only? boolean Kill the process when playback of the current playlist entry ends (default: true).
---@field capture_size? integer Maximum captured bytes per stream (default: 64 MiB).
---@field capture_stdout? boolean Capture stdout.
---@field capture_stderr? boolean Capture stderr.
---@field detach? boolean Run the process in a new process session.
---@field env? mp.utils.Environment Environment entries in `NAME=VALUE` form; an empty list inherits mpv's environment.
---@field stdin_data? string Data to feed to the process's standard input.
---@field passthrough_stdin? boolean Connect the process's standard input to mpv's standard input.
---@field cancellable? boolean Legacy name for `playback_only`.
---@field max_size? integer Legacy name for `capture_size`.

---@class mp.utils.SubprocessResult
---@field status integer Exit status, or a negative value on error.
---@field stdout? string Captured stdout, when requested.
---@field stderr? string Captured stderr, when requested.
---@field error_string string Empty on normal termination; otherwise an error such as `killed` or `init`.
---@field killed_by_us? boolean Whether mpv killed the process; absent only if command parsing itself failed.
---@field error? string Legacy copy of a non-empty `error_string`.

---@class mp.utils.DetachedSubprocessOptions
---@field args string[] Executable followed by its arguments.

---@alias mp.utils.JsonValue nil|boolean|number|string|mp.utils.JsonArray|mp.utils.JsonObject
---@alias mp.utils.JsonArray mp.utils.JsonValue[]
---@alias mp.utils.JsonObject table<string, mp.utils.JsonValue>

---Return the working directory that mpv was launched from.
---
---On error, returns `nil, error`.
---@return mp.utils.Path? path
---@return string? error
function utils.getcwd() end

---Enumerate entries in a directory. The returned names do not include the
---directory path and are not sorted.
---
---On error, returns `nil, error`.
---@param path mp.utils.Path
---@param filter? mp.utils.ReaddirFilter
---@return string[]? entries
---@return string? error
function utils.readdir(path, filter) end

---Return filesystem metadata for a path.
---
---On error, returns `nil, error`.
---@param path mp.utils.Path
---@return mp.utils.FileInfo? info
---@return string? error
function utils.file_info(path) end

---Split a path into its directory and trailing filename components.
---@param path mp.utils.Path
---@return mp.utils.Path directory
---@return string filename
function utils.split_path(path) end

---Join two paths. If `p2` is absolute, it is returned unchanged.
---@param p1 mp.utils.Path
---@param p2 mp.utils.Path
---@return mp.utils.Path path
function utils.join_path(p1, p2) end

---Format a table recursively for debugging.
---
---This helper is exposed by mpv's Lua defaults but is not part of the
---documented, stable scripting API.
---@param value table
---@param seen? table<table, boolean> Internal recursion state.
---@return string
function utils.format_table(value, seen) end

---Convert any Lua value to a debugging string, formatting tables recursively.
---@param value unknown
---@param seen? table<table, boolean> Internal recursion state.
---@return string
function utils.to_string(value, seen) end

---Format a byte count using binary units such as KiB and MiB.
---
---This helper is exposed by mpv's Lua defaults but is not part of the
---documented, stable scripting API.
---@param bytes number
---@return string
function utils.format_bytes_humanized(bytes) end

---Run an external process synchronously and capture stdout by default.
---
---This is a legacy wrapper around the native `subprocess` command. Prefer
---`mp.command_native` or `mp.command_native_async` in new scripts.
---@param options mp.utils.SubprocessOptions
---@return mp.utils.SubprocessResult result
function utils.subprocess(options) end

---Run an external process detached from mpv's control.
---
---This is a legacy wrapper around the `run` command.
---@param options mp.utils.DetachedSubprocessOptions
---@return nil
function utils.subprocess_detached(options) end

---Return the process ID of the running mpv process.
---@return integer? pid
---@return string? error
function utils.getpid() end

---Return the C environment as strings in `NAME=VALUE` form.
---@return mp.utils.Environment environment
function utils.get_env_list() end

---Parse JSON into Lua values.
---
---The third return value is always the unconsumed trailing text. If `trail`
---is false, non-whitespace trailing text causes an error. JSON `null` and a
---parse error can both produce `nil`; inspect the second result to distinguish
---them.
---@param json string
---@param trail? boolean Allow trailing non-whitespace text.
---@return mp.utils.JsonValue value
---@return string? error
---@return string trailing
function utils.parse_json(json, trail) end

---Serialize a Lua value as JSON.
---
---On error, returns `nil, error`.
---@param value mp.utils.JsonValue
---@return string? json
---@return string? error
function utils.format_json(value) end

return utils
