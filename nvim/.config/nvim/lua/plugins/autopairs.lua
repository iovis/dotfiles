return {
  "windwp/nvim-autopairs",
  -- enabled = false,
  event = "VeryLazy",
  config = function()
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.setup({
      check_ts = true,
      disable_filetype = {
        "TelescopePrompt",
        "fzf",
      },
      disable_in_macro = true,
    })

    ---- Disable `[` for checkboxes in markdown
    npairs.get_rules("[")[1]:with_pair(cond.not_before_text("- "))

    ---- Support space padding after pair
    local brackets = { { "[", "]" }, { "{", "}" } }

    npairs.add_rules({
      Rule(" ", " ")
        :with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)

          return vim.tbl_contains({
            brackets[1][1] .. brackets[1][2],
            brackets[2][1] .. brackets[2][2],
          }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = opts.line:sub(col - 1, col + 2)

          return vim.tbl_contains({
            brackets[1][1] .. "  " .. brackets[1][2],
            brackets[2][1] .. "  " .. brackets[2][2],
          }, context)
        end),
    })

    for _, bracket in pairs(brackets) do
      Rule("", " " .. bracket[2])
        :with_pair(cond.none())
        :with_move(function(opts)
          return opts.char == bracket[2]
        end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key(bracket[2])
    end
  end,
}
