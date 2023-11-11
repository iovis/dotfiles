vim.filetype.add({
  extension = {
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
