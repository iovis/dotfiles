return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      css = { "stylelint" },
      erb = { "erb_lint" },
      fish = { "fish" },
      yaml = { "yamllint" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPre", "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
