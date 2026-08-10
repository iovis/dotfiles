function FuzzyFindFiles(_text, _)
  local files = vim.fn.glob("`fd -H -E '.git' -E '.keep' --type file`", true, true)
  return files
  -- FIXME: blink v1 doesn't play well with `findfunc` (fixed in v2)
  -- return vim.fn.matchfuzzy(files, text)
end

vim.keymap.set("n", "f<space>", ":find ")
vim.opt.findfunc = "v:lua.FuzzyFindFiles"
