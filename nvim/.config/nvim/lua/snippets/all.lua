local commentstr = function()
  -- Update commentstring with treesitter
  local ok, ts_comment = pcall(require, "ts_context_commentstring.internal")
  if ok then
    ts_comment.update_commentstring({})
  end

  -- Substitute %s with one space
  return vim.api.nvim_buf_get_option(0, "commentstring"):gsub("%s*%%s", " ")
end

return {
  s("#!", {
    t("#!/usr/bin/env "),
    i(1, "bash"),
  }),
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
