return {
  "luukvbaal/statuscol.nvim",
  -- enabled = false,
  config = function()
    local builtin = require("statuscol.builtin")

    require("statuscol").setup({
      relculright = true, -- right align current line
      segments = {
        { text = { "%s" }, click = "v:lua.ScSa" },
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
      },
    })
  end,
}
