return {
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostics = {
        disable = { "missing-fields" },
        unusedLocalExclude = { "_*" }, -- Don't warn about variables that start with underscore
      },
      format = { enable = false },
      hint = {
        enable = true,
        arrayIndex = "Disable",
      },
      -- workspace = { checkThirdParty = false },
    },
  },
}
