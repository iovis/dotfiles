return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        globals = {
          "vim",
          "pp", -- pretty print
          -- luassert
          "before_each",
          "describe",
          "it",
          -- luasnip globals (luasnip.config.snip_env)
          -- https://github.com/L3MON4D3/LuaSnip/blob/master/lua/luasnip/config.lua
          "s", -- snippet
          "sn", -- snippet node
          "t", -- text node
          "f", -- function node
          "i", -- insert node
          "c", -- choice node
          "d", -- dynamic node
          "r", -- restore node
          "l", -- lambda
          "rep", -- repeat node
          "p", -- partial
          "m", -- match
          "n", -- nonempty
          "dl", -- dynamic lambda
          "fmt", -- format (uses {} as placeholder)
          "fmta", -- format (uses <> as placeholder)
          "conds",
          "types",
          "events",
          "parse", -- parse snipmate format
          "ai",
        },
        -- unusedLocalExclude = {
        --   "_*", -- Don't warn about variables that start with underscore
        -- },
      },
      -- hint = {
      --   enable = true,
      -- },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
