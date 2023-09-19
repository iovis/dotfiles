vim.filetype.add({
  extension = {
    tmux = "tmux",
  },
  filename = {
    ["pryrc"] = "ruby",
    [".clang-format"] = "yaml",
    ["PULLREQ_EDITMSG"] = "gitcommit",
  },
  pattern = {
    [".*/yamllint/config"] = "yaml",
  },
})
