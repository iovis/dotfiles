return {
  "iovis/jirafa.vim",
  event = "VeryLazy",
  config = function()
    vim.g.jira_url = vim.env.JIRA_URL
    -- vim.g.jira_url = vim.fn.DotenvGet("JIRA_URL")
  end,
}
