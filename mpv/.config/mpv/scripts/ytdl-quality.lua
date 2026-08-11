local input = require("mp.input")
local mp = require("mp")
local msg = require("mp.msg")
local utils = require("mp.utils")

local formats_by_url = {}
local preferences_by_url = {}
local configured_format = mp.get_property("ytdl-format", "")

local function has_codec(codec)
  return type(codec) == "string" and codec ~= "" and codec ~= "none"
end

local function is_video_format(format)
  return type(format) == "table" and format.vcodec ~= "none"
end

local function short_codec(codec)
  if not has_codec(codec) then
    return "Unknown codec"
  end

  local name = codec:lower()
  if name:find("^av01") then
    return "AV1"
  elseif name:find("^vp0?9") then
    return "VP9"
  elseif name:find("^avc") or name:find("^h264") then
    return "H.264"
  elseif name:find("^hev") or name:find("^hvc") or name:find("^h265") then
    return "HEVC"
  elseif name:find("^vp0?8") then
    return "VP8"
  end

  return codec:match("^[^.]+") or codec
end

local function compact_number(value)
  local rounded = math.floor(value + 0.5)
  if math.abs(value - rounded) < 0.01 then
    return tostring(rounded)
  end

  return string.format("%.2f", value):gsub("0+$", ""):gsub("%.$", "")
end

local function quality_label(format)
  local height = tonumber(format.height)
  local fps = tonumber(format.fps)
  local label

  if height then
    label = string.format("%dp", height)
  elseif type(format.resolution) == "string" and format.resolution ~= "" then
    label = format.resolution
  else
    label = "Unknown resolution"
  end

  if fps and fps > 0 then
    label = label .. compact_number(fps)
  end

  return label
end

local function bitrate_label(format)
  local bitrate = tonumber(format.vbr) or tonumber(format.tbr)
  if not bitrate or bitrate <= 0 then
    return nil
  elseif bitrate >= 1000 then
    return string.format("%.1f Mb/s", bitrate / 1000)
  end

  return string.format("%.0f kb/s", bitrate)
end

local function size_label(format)
  local size = tonumber(format.filesize)
  local approximate = false
  if not size then
    size = tonumber(format.filesize_approx)
    approximate = size ~= nil
  end

  if not size or size <= 0 then
    return nil
  end

  return (approximate and "~" or "") .. utils.format_bytes_humanized(size)
end

local function format_label(format, current_video_id)
  local parts = {
    quality_label(format),
    short_codec(format.vcodec),
  }

  local dynamic_range = format.dynamic_range
  if type(dynamic_range) == "string" and dynamic_range ~= "" and dynamic_range:upper() ~= "SDR" then
    parts[#parts + 1] = dynamic_range
  end

  local bitrate = bitrate_label(format)
  if bitrate then
    parts[#parts + 1] = bitrate
  end

  local size = size_label(format)
  if size then
    parts[#parts + 1] = size
  end

  if has_codec(format.acodec) then
    parts[#parts + 1] = "muxed audio"
  end

  if type(format.ext) == "string" and format.ext ~= "" then
    parts[#parts + 1] = format.ext:upper()
  end

  parts[#parts + 1] = "id " .. format.id

  local marker = format.id == current_video_id and "● " or "○ "
  return marker .. table.concat(parts, " · ")
end

local function classify_current_format(json, formats_by_id)
  local current_video_id
  local current_audio_id

  local function classify(format)
    if type(format) ~= "table" or format.format_id == nil then
      return
    end

    local id = tostring(format.format_id)
    if id:find("+", 1, true) then
      for part in id:gmatch("[^+]+") do
        classify(formats_by_id[part] or { format_id = part })
      end
      return
    end

    local known_format = formats_by_id[id] or format
    local has_video = is_video_format(known_format)
    local has_audio = has_codec(known_format.acodec)

    if has_video and not current_video_id then
      current_video_id = id
    end
    if has_audio and not has_video and not current_audio_id then
      current_audio_id = id
    end
  end

  local requested = json.requested_formats or json.requested_downloads
  if type(requested) == "table" then
    for _, format in ipairs(requested) do
      classify(format)
    end
  end

  if not current_video_id and json.format_id ~= nil then
    classify({ format_id = json.format_id, vcodec = json.vcodec, acodec = json.acodec })
  end

  return current_video_id, current_audio_id
end

local function parse_formats(json_text)
  local json, parse_error = utils.parse_json(json_text)
  if type(json) ~= "table" then
    return nil, parse_error or "yt-dlp returned invalid JSON"
  end

  if type(json.formats) ~= "table" then
    return nil, "yt-dlp did not report any formats"
  end

  local formats = {}
  local formats_by_id = {}

  for _, format in ipairs(json.formats) do
    if type(format) == "table" and format.format_id ~= nil then
      format.id = tostring(format.format_id)
      formats_by_id[format.id] = format
    end
  end

  -- yt-dlp orders formats from worst to best. Reverse that order so the
  -- highest-quality choices appear first while retaining yt-dlp's preferences.
  for index = #json.formats, 1, -1 do
    local format = json.formats[index]
    if type(format) == "table" and format.id and is_video_format(format) then
      formats[#formats + 1] = format
    end
  end

  if #formats == 0 then
    return nil, "yt-dlp did not report any video formats"
  end

  local current_video_id, current_audio_id = classify_current_format(json, formats_by_id)
  return {
    formats = formats,
    current_video_id = current_video_id,
    current_audio_id = current_audio_id,
  }
end

local function reload_current_url(url)
  local duration = mp.get_property_number("duration")
  local position = mp.get_property_number("time-pos")
  local paused = mp.get_property_native("pause", false)

  local function restore_playback_state()
    mp.unregister_event(restore_playback_state)
    if mp.get_property("path") ~= url then
      return
    end

    if duration and duration > 0 and position then
      mp.commandv("seek", position, "absolute+exact")
    end
    mp.set_property_native("pause", paused)
  end

  mp.register_event("file-loaded", restore_playback_state)
  mp.commandv("playlist-play-index", "current")
end

local function format_selector(format, current_audio_id)
  if has_codec(format.acodec) then
    return format.id
  end

  local audio = current_audio_id or "bestaudio"
  return string.format("%s+%s/%s", format.id, audio, format.id)
end

local function select_quality()
  local url = mp.get_property("path")
  local data = url and formats_by_url[url]
  if not data then
    mp.osd_message("yt-dlp quality information is unavailable")
    return
  end

  local uses_automatic_format = configured_format == "" or configured_format == "ytdl"
  local default_label = uses_automatic_format and "Automatic (yt-dlp default)"
    or "Configured default (" .. configured_format .. ")"
  local choices = { { label = default_label } }
  local items = { default_label }
  local default_item = 1

  for _, format in ipairs(data.formats) do
    choices[#choices + 1] = format
    items[#items + 1] = format_label(format, data.current_video_id)
    if format.id == data.current_video_id then
      default_item = #items
    end
  end

  input.select({
    prompt = "Select yt-dlp video quality:",
    items = items,
    default_item = default_item,
    submit = function(index)
      local choice = choices[index]
      if not choice then
        return
      end

      if not choice.id then
        if not preferences_by_url[url] then
          mp.osd_message("Already using the configured yt-dlp default")
          return
        end

        preferences_by_url[url] = nil
        reload_current_url(url)
        return
      end

      local selector = format_selector(choice, data.current_audio_id)
      preferences_by_url[url] = selector
      if choice.id == data.current_video_id then
        mp.osd_message("Quality already active: " .. quality_label(choice))
        return
      end

      reload_current_url(url)
    end,
  })
end

mp.observe_property("user-data/mpv/ytdl/json-subprocess-result", "native", function(_, result)
  if type(result) ~= "table" or result.status ~= 0 or type(result.stdout) ~= "string" then
    return
  end

  local url = mp.get_property("path")
  if not url then
    return
  end

  local data, parse_error = parse_formats(result.stdout)
  if not data then
    msg.warn("Could not read yt-dlp formats: " .. tostring(parse_error))
    return
  end

  formats_by_url[url] = data
end)

-- Apply session choices before mpv's ytdl hook runs at priority 10.
mp.add_hook("on_load", 9, function()
  local url = mp.get_property("path")
  local preference = url and preferences_by_url[url]
  if preference then
    mp.set_property("file-local-options/ytdl-format", preference)
  end
end)

mp.add_key_binding(nil, "select", select_quality)
