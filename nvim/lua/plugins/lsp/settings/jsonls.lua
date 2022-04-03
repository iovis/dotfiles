return {
  settings = {
    json = {
      -- https://www.schemastore.org/json/
      -- https://github.com/b0o/schemastore.nvim
      schemas = require("schemastore").json.schemas(),
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  },
}
