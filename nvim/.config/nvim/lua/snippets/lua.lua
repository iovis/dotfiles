local u = require("config.utils")

return {
  -- Neovim
  s(
    "augroup",
    fmta(
      [[
        local augroup = vim.api.nvim_create_augroup("<>", { clear = true })
      ]],
      { i(1) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "autocmd",
    fmta(
      [[
        vim.api.nvim_create_autocmd(<>, {
          group = <>,
          pattern = <>,
          callback = function()
            <>
          end,
        })
      ]],
      {
        i(1, '"User"'),
        i(2, "augroup"),
        i(3, '"VeryLazy"'),
        i(0, "-- TODO"),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- .nvim.lua
  s(
    "filetype",
    fmta(
      [[
        vim.api.nvim_create_autocmd("FileType", {
          group = vim.api.nvim_create_augroup("my.filetype", { clear = true }),
          pattern = { "<>" },
          callback = function()
            <>
          end,
        })
      ]],
      {
        i(1, "c"),
        i(0, "-- TODO"),
      }
    ),
    {
      show_condition = u.ls.within(".nvim.lua"),
      condition = conds.line_begin * u.ls.within(".nvim.lua"),
    }
  ),
  s(
    "rubylsp",
    fmta(
      [[
        vim.lsp.config("ruby_lsp", {
          init_options = {
            formatter = "<>",
            linters = { "<>" },
          },
        })

        vim.lsp.enable({ "ruby_lsp" })
      ]],
      {
        i(1, "standard"),
        i(2, "standard"),
      }
    ),
    {
      show_condition = u.ls.within(".nvim.lua"),
      condition = conds.line_begin * u.ls.within(".nvim.lua"),
    }
  ),
  -- Quick imports
  s("u", t('local u = require("config.utils")'), {
    condition = conds.line_begin,
  }),
  s("t", t('local tux = require("tux")'), {
    condition = conds.line_begin,
  }),
  -- Lua
  s("styluaignore", t("-- stylua: ignore"), {
    condition = conds.line_begin,
  }),
  s("as", fmt("--[[@as {}]]", { i(1, "<type>") })), -- TODO: Do alternate for `--[=[@as string[]]=]`
  s("p", fmt("vim.print({})", { i(1) }), {
    condition = conds.line_begin,
  }),
  s("logd", fmt('vim.notify("{}", vim.log.levels.DEBUG)', { i(1) }), {
    condition = conds.line_begin,
  }),
  s("loge", fmt('vim.notify("{}", vim.log.levels.ERROR)', { i(1) }), {
    condition = conds.line_begin,
  }),
  s("logi", fmt('vim.notify("{}")', { i(1) }), {
    condition = conds.line_begin,
  }),
  s("logw", fmt('vim.notify("{}", vim.log.levels.WARN)', { i(1) }), {
    condition = conds.line_begin,
  }),
}
