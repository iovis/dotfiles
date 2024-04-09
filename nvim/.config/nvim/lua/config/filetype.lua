vim.filetype.add({
  extension = {
    dbout = "dbout",
    nbt = "numbat",
    templ = "templ",
    tmux = "tmux",
    zon = "zig",
  },
  filename = {
    Brewfile = "ruby",
    PULLREQ_EDITMSG = "gitcommit",
    [".clang-format"] = "yaml",
    justfile = "just",
    pryrc = "ruby",
  },
  pattern = {
    [".*/yamllint/config"] = "yaml",
  },
})
