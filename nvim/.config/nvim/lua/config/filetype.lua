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
    [".*"] = {
      priority = -math.huge,
      function(_, bufnr)
        local content = vim.filetype.getlines(bufnr, 1)

        if vim.filetype.matchregex(content, [[^#!.*\<cargo\>]]) then
          return "rust"
        end
      end,
    },
  },
})
