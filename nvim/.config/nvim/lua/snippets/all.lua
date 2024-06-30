local commentstr = function(annotation)
  return function()
    -- Update commentstring with treesitter
    local ok, ts_comment = pcall(require, "ts_context_commentstring.internal")
    if ok then
      ts_comment.update_commentstring({})
    end

    -- Something like `-- %s` or `<!--%s-->`
    local commentstr = vim.split(vim.bo.commentstring, "%s", {
      plain = true,
      trimempty = true,
    })

    if #commentstr == 1 then
      -- { t("-- "), t("TODO: "), i(1) }
      return sn(nil, {
        t(commentstr[1]),
        t(annotation .. " "),
        i(1),
      })
    else
      -- { t("<!--"), t(" TODO: "), i(1), t(" -->") }
      return sn(nil, {
        t(commentstr[1]),
        t(" " .. annotation .. " "),
        i(1),
        t(" " .. commentstr[2]),
      })
    end
  end
end

local filetype = function()
  local filetype = vim.bo.filetype
  if filetype == "" then
    filetype = "bash"
  end
  return sn(nil, i(1, filetype))
end

return {
  s("todo", d(1, commentstr("TODO:"))),
  s("warn", d(1, commentstr("WARN:"))),
  s("note", d(1, commentstr("NOTE:"))),
  s("hack", d(1, commentstr("HACK:"))),
  s("fixme", d(1, commentstr("FIXME:"))),
  s("#!", fmt("#!/usr/bin/env {}", { d(1, filetype) }), {
    condition = conds.line_begin,
  }),
}
