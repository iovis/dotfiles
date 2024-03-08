local commentstr = function()
  -- Update commentstring with treesitter
  local ok, ts_comment = pcall(require, "ts_context_commentstring.internal")
  if ok then
    ts_comment.update_commentstring({})
  end

  -- Remove `%s` from commentstr
  -- Example (lua): `-- %s`
  return vim.bo.commentstring:gsub("%s*%%s", "")
end

local filetype = function()
  local filetype = vim.bo.filetype
  if filetype == "" then
    filetype = "bash"
  end
  return sn(nil, i(1, filetype))
end

return {
  s("todo", fmt("{} TODO: ", { p(commentstr) })),
  s("warn", fmt("{} WARN: ", { p(commentstr) })),
  s("note", fmt("{} NOTE: ", { p(commentstr) })),
  s("hack", fmt("{} HACK: ", { p(commentstr) })),
  s("fixme", fmt("{} FIXME: ", { p(commentstr) })),
  s("#!", fmt("#!/usr/bin/env {}", { d(1, filetype) }), {
    condition = conds.line_begin,
  }),
}
