vim.filetype.add({
  extension = {
    dbout = "dbout",
    nbt = "numbat",
    tmux = "tmux",
    zon = "zig",
  },
  filename = {
    Brewfile = "ruby",
    PULLREQ_EDITMSG = "gitcommit",
    [".clang-format"] = "yaml",
    pryrc = "ruby",
  },
  pattern = {
    [".*/yamllint/config"] = "yaml",
  },
})
