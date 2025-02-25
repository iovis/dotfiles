return {
  "FabijanZulj/blame.nvim",
  cmd = { "BlameToggle" },
  keys = {
    -- { "<leader>gb", "<cmd>BlameToggle window<cr>" },
    { "yob", "<cmd>BlameToggle virtual<cr>" },
  },
  config = function()
    local blame = require("blame")
    blame.setup({
      date_format = "%Y-%m-%d",
      commit_detail_view = "split",
      mappings = {
        commit_info = "i",
        stack_push = "-",
        stack_pop = "_",
        show_commit = "<CR>",
        close = { "<esc>", "q" },
      },
    })
  end,
}
