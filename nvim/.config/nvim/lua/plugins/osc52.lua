return {
  "ojroques/nvim-osc52",
  -- enabled = vim.fn.has("nvim-0.10") ~= 1, -- TODO: nvim v0.10
  event = "VeryLazy",
  config = function()
    if not vim.env.SSH_CLIENT then
      return
    end

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
