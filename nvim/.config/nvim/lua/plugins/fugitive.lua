return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  dependencies = {
    "tpope/vim-rhubarb",
  },
  config = function()
    vim.keymap.set("n", "<leader>G", "<cmd>Gtabedit:<cr>)", { remap = true })
    vim.keymap.set("n", "<leader>go", "<cmd>Gread<cr>")
    vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>")
    vim.keymap.set("n", "<leader>lg", "<cmd>Glol -500<cr>")
    vim.keymap.set({ "n", "x" }, "<leader>gg", ":GBrowse<cr>", { silent = true })

    vim.cmd([[
      command! -nargs=*        Glol Git log --graph --pretty='%h -%d %s (%cr) <%an>' <args>
      command! -range -nargs=* GLogL Git log -L <line1>,<line2>:% <args>

      command! -nargs=0 Gcm   !git checkout main
      command! -nargs=0 Gcq   !git checkout qa
      command! -nargs=0 Gpsup !git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
      command! -nargs=0 Grhh  !git reset --hard
      command! -nargs=1 Gcb   !git checkout -b <args>
    ]])

    local u = require("config.utils")
    u.cabbrev("Git")

    local fugitive_augroup = vim.api.nvim_create_augroup("fugitive_augroup", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Fugitive keymaps",
      group = fugitive_augroup,
      pattern = "fugitive",
      callback = function(params)
        vim.keymap.set("n", "cc", "<cmd>Git commit -v<cr>", {
          buffer = params.buf,
        })
      end,
    })
  end,
}
