return {
  "ojroques/nvim-osc52",
  event = "VeryLazy",
  cond = function()
    return vim.env.SSH_CLIENT ~= nil
  end,
  config = function()
    require("osc52").setup({})

    local osc52_augroup = vim.api.nvim_create_augroup("osc52_yank", { clear = true })
    vim.api.nvim_create_autocmd("TextYankPost", {
      desc = "OSC52 yank",
      group = osc52_augroup,
      callback = function()
        if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
          require("osc52").copy_register("+")
        end
      end,
    })
  end,
}