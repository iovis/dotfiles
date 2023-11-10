local workspace_libraries = vim.api.nvim_get_runtime_file("", true)
table.insert(workspace_libraries, "/Users/david/.dotfiles/hammerspoon/.hammerspoon/Spoons/EmmyLua.spoon/annotations")

return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        globals = {
          "vim",
          ----plenary.test_harness
          -- https://github.com/nvim-lua/plenary.nvim/blob/master/TESTS_README.md
          "describe",
          "it",
          "pending",
          "before_each",
          "after_each",
          ----luasnip globals (luasnip.config.snip_env)
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
        library = workspace_libraries,
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
