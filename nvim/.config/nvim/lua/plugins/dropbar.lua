return {
  "Bekaboo/dropbar.nvim",
  enabled = false, -- requires neovim v0.10
  config = function()
    require("dropbar").setup()

    vim.keymap.set("n", "dp", require("dropbar.api").pick, { desc = "dropbar.pick" })

    ----Toggle winbar
    local show_winbar = true
    vim.keymap.set("n", "yoB", function()
      if show_winbar then
        vim.cmd("set winbar=")
      else
        vim.cmd("set winbar=%{%v:lua.dropbar.get_dropbar_str()%}")
      end

      show_winbar = not show_winbar
    end, { desc = "Toggle barbecue" })
  end,
}
