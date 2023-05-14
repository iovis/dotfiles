return {
  "luukvbaal/statuscol.nvim",
  -- enabled = false,
  config = function()
    local builtin = require("statuscol.builtin")

    require("statuscol").setup({
      clickmod = "c", -- "a" for Alt, "c" for Ctrl and "m" for Meta.
      relculright = true,
      segments = {
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        { text = { "%s" }, click = "v:lua.ScSa" },
        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
      },
    })
  end,
}
