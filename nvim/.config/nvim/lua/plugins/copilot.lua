return {
  "github/copilot.vim",
  init = function()
    vim.g.copilot_no_tab_map = true

    vim.keymap.set("n", "yoq", function()
      if vim.fn["copilot#Enabled"]() == 1 then
        vim.cmd.Copilot("disable")
      else
        vim.cmd.Copilot("enable")
      end

      vim.cmd.Copilot("status")
    end, { desc = "Toggle Copilot" })

    vim.keymap.set("i", "<m-cr>", "copilot#Accept()", {
      replace_keycodes = false,
      expr = true,
    })

    vim.keymap.set("n", "<leader>lc", "<cmd>Copilot panel<cr>", {
      desc = "Open Copilot panel",
    })

    vim.keymap.set("i", "<m-g>", "<Plug>(copilot-suggest)")

    vim.keymap.set("i", "<m-down>", "<Plug>(copilot-next)")
    vim.keymap.set("i", "<m-up>", "<Plug>(copilot-previous)")

    vim.keymap.set("i", "<m-left>", "<Plug>(copilot-dismiss)")
    vim.keymap.set("i", "<m-right>", "<Plug>(copilot-accept-line)")
  end,
}
