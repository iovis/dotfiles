-- Based on mpv 0.41.0's bundled player/lua/assdraw.lua.
---@meta

---@class mp.assdraw.Builder
---@field scale number ASS drawing scale exponent. Defaults to 4.
---@field text string Accumulated ASS events and drawing commands.
---@field new_event fun(self: mp.assdraw.Builder) Start a new ASS event line when text is present.
---@field draw_start fun(self: mp.assdraw.Builder) Enter ASS vector drawing mode using the current scale.
---@field draw_stop fun(self: mp.assdraw.Builder) Leave ASS vector drawing mode.
---@field coord fun(self: mp.assdraw.Builder, x: number, y: number) Append a scaled drawing coordinate.
---@field append fun(self: mp.assdraw.Builder, text: string) Append raw ASS text.
---@field merge fun(self: mp.assdraw.Builder, other: mp.assdraw.Builder) Append another builder's text.
---@field pos fun(self: mp.assdraw.Builder, x: number, y: number) Append an ASS position tag.
---@field an fun(self: mp.assdraw.Builder, alignment: integer) Append an ASS alignment tag.
---@field move_to fun(self: mp.assdraw.Builder, x: number, y: number) Begin a drawing contour at a coordinate.
---@field line_to fun(self: mp.assdraw.Builder, x: number, y: number) Draw a line to a coordinate.
---@field bezier_curve fun(self: mp.assdraw.Builder, x1: number, y1: number, x2: number, y2: number, x3: number, y3: number) Draw a cubic Bezier curve.
---@field rect_ccw fun(self: mp.assdraw.Builder, x0: number, y0: number, x1: number, y1: number) Draw a counterclockwise rectangle.
---@field rect_cw fun(self: mp.assdraw.Builder, x0: number, y0: number, x1: number, y1: number) Draw a clockwise rectangle.
---@field hexagon_cw fun(self: mp.assdraw.Builder, x0: number, y0: number, x1: number, y1: number, r1: number, r2?: number) Draw a clockwise clipped-corner rectangle.
---@field hexagon_ccw fun(self: mp.assdraw.Builder, x0: number, y0: number, x1: number, y1: number, r1: number, r2?: number) Draw a counterclockwise clipped-corner rectangle.
---@field round_rect_cw fun(self: mp.assdraw.Builder, x0: number, y0: number, x1: number, y1: number, r1: number, r2?: number) Draw a clockwise rounded rectangle.
---@field round_rect_ccw fun(self: mp.assdraw.Builder, x0: number, y0: number, x1: number, y1: number, r1: number, r2?: number) Draw a counterclockwise rounded rectangle.

local assdraw = {}

---Create an ASS text and vector-drawing builder.
---@return mp.assdraw.Builder builder
function assdraw.ass_new() end

return assdraw
