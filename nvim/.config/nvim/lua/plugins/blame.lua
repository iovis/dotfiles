return {
  "FabijanZulj/blame.nvim",
  cmd = { "BlameToggle" },
  keys = {
    { "<leader>gb", "<cmd>BlameToggle window<cr>" },
    { "yob", "<cmd>BlameToggle virtual<cr>" },
  },
  config = function()
    local blame = require("blame")
    blame.setup({
      date_format = "%Y-%m-%d",
      commit_detail_view = "tab",
    })
  end,
}
