return {
  "luukvbaal/statuscol.nvim",
  -- enabled = false,
  config = function()
    local builtin = require("statuscol.builtin")

    -- TODO: marks in statuscol
    -- :h statuscolumn
    -- "%#" .. sign.texthl .. "#" .. text .. "%*"
    -- "%#DiagnosticHing#a%*"
    --
    -- Maybe muxi has an option:
    --   - Than enables the feature?
    --   - That keeps a reverse list of marks?
    --   - That finds and formats the mark?
    --   - Maybe lets the user choose highlight or format string?
    --
    -- se stc?
    -- %!v:lua.StatusCol()
    -- %@v:lua.ScSa@%s%T%@v:lua.ScFa@%T%@v:lua.ScLa@%=26 %T
    require("statuscol").setup({
      relculright = true, -- right align current line
      segments = {
        { text = { "%s" }, click = "v:lua.ScSa" }, -- signs
        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" }, -- folds
        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }, -- line number
      },
    })
  end,
}
