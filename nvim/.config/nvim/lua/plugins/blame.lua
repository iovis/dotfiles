return {
  "FabijanZulj/blame.nvim",
  cmd = { "BlameToggle" },
  keys = {
    -- { "<leader>gb", "<cmd>BlameToggle window<cr>" },
    { "yob", "<cmd>BlameToggle virtual<cr>", desc = "Git blame (virtual text)" },
  },
  config = function()
    local blame = require("blame")
    blame.setup({
      date_format = "%Y-%m-%d",
      commit_detail_view = "split",
      mappings = {
        commit_info = "i",
        stack_push = "<tab>",
        stack_pop = "<s-tab>",
        show_commit = "<cr>",
        close = { "<esc>", "q" },
      },
    })
  end,
}
