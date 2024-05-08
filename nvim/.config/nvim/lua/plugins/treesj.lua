return {
  "Wansmer/treesj",
  keys = {
    { "'j", ":TSJJoin<cr>", silent = true },
    { "'s", ":TSJSplit<cr>", silent = true },
  },
  dependencies = {
    "AndrewRadev/splitjoin.vim",
  },
  config = function()
    require("treesj").setup({
      use_default_keymaps = false,
      langs = {
        -- Fallback to splitjoin.vim for modules/classes
        ruby = {
          module = {
            both = {
              no_format_with = {}, -- Need to avoid 'no format with comment'
              fallback = function(_)
                vim.cmd("SplitjoinJoin")
              end,
            },
          },
          class = {
            both = {
              no_format_with = {},
              fallback = function(_)
                vim.cmd("SplitjoinSplit")
              end,
            },
          },
        },
      },
    })
  end,
}
