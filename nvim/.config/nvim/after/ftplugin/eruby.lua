----Surround
require("nvim-surround").buffer_setup({
  surrounds = {
    ["="] = {
      add = { "<%= ", " %>" },
      find = "<%%= .- %%>",
      delete = "^(<%%= )().-( %%>)()$",
    },
    ["#"] = {
      add = { "<%# ", " %>" },
      find = "<%%# .- %%>",
      delete = "^(<%%# )().-( %%>)()$",
    },
    ["-"] = {
      add = { "<% ", " %>" },
      find = "<%% .- %%>",
      delete = "^(<%% )().-( %%>)()$",
    },
  },
})
