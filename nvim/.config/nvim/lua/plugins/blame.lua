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

    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "BlameViewOpened",
    --   callback = function(event)
    --     local blame_type = event.data
    --     if blame_type == "window" then
    --       require("barbecue.ui").toggle(false)
    --     end
    --   end,
    -- })
    --
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "BlameViewClosed",
    --   callback = function(event)
    --     local blame_type = event.data
    --     if blame_type == "window" then
    --       require("barbecue.ui").toggle(true)
    --     end
    --   end,
    -- })
  end,
}
