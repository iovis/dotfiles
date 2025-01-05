----Surround
vim.b.minisurround_config = {
  custom_surroundings = {
    ["="] = {
      input = { "<%%= ().-() %%>" },
      output = { left = "<%= ", right = " %>" },
    },
    ["#"] = {
      input = { "<%%# ().-() %%>" },
      output = { left = "<%# ", right = " %>" },
    },
    ["-"] = {
      input = { "<%% ().-() %%>" },
      output = { left = "<% ", right = " %>" },
    },
  },
}
