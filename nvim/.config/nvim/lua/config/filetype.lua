vim.filetype.add({
  extension = {
    tmux = "tmux",
  },
  filename = {
    ["pryrc"] = "ruby",
    [".clang-format"] = "yaml",
  },
  pattern = {
    [".*/yamllint/config"] = "yaml",
  },
})
