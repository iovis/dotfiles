local M = {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    {
      "<leader>z",
      "<cmd>ZenMode<cr>",
    },
  },
}

function M.config()
  local ok, zen = pcall(require, "zen-mode")
  if not ok then
    print("zen-mode not found!")
    return
  end

  zen.setup({
    window = {
      backdrop = 1,
      height = 0.9,
      width = 0.8,
      options = {
        -- Any vim.wo options
        signcolumn = "no",
        number = false,
        relativenumber = false,
      },
    },
  })
end

return M
