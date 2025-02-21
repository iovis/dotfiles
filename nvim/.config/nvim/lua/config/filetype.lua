vim.filetype.add({
  extension = {
    dbout = "dbout",
    http = "http",
    nbt = "numbat",
    rbs = "ruby",
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
    ["Gemfile.*"] = function(path)
      if not path:match(".lock") then
        return "ruby"
      end
    end,
  },
})
