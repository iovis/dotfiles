local commentstr = function()
  -- Substitute %s with one space
  return vim.api.nvim_buf_get_option(0, "commentstring"):gsub("%%s", " ")
end

return {
  s("todo", {
    p(commentstr),
    t("TODO: "),
    i(0),
  }),
  s("warn", {
    p(commentstr),
    t("WARN: "),
    i(0),
  }),
  s("note", {
    p(commentstr),
    t("NOTE: "),
    i(0),
  }),
  s("hack", {
    p(commentstr),
    t("HACK: "),
    i(0),
  }),
  s("fixme", {
    p(commentstr),
    t("FIXME: "),
    i(0),
  }),
}
