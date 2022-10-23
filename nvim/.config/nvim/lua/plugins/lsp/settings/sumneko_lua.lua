return {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "pp", -- pretty print
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
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
