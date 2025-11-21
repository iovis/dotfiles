return {
  "github/copilot.vim",
  init = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_filetypes = {
      gitcommit = true,
      oil = false,
    }

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

    vim.keymap.set("i", "<m-c>", "<esc><cmd>Copilot panel<cr>")
    vim.keymap.set("i", "<m-s>", "<Plug>(copilot-suggest)")

    vim.keymap.set("i", "<m-down>", "<Plug>(copilot-next)")
    vim.keymap.set("i", "<m-up>", "<Plug>(copilot-previous)")

    vim.keymap.set("i", "<m-h>", "<Plug>(copilot-dismiss)")
    vim.keymap.set("i", "<m-l>", "<Plug>(copilot-accept-line)")
    vim.keymap.set("i", "<m-w>", "<Plug>(copilot-accept-word)")
  end,
}
