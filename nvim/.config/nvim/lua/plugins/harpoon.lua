return {
  "ThePrimeagen/harpoon",
  -- enabled = false,
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "ge", require("harpoon.ui").toggle_quick_menu, { desc = "Toggle Harpoon" })
    vim.keymap.set("n", "gh", require("harpoon.mark").add_file, { desc = "Add file to Harpoon" })

    vim.keymap.set("n", "gH", function()
      require("harpoon.mark").clear_all()
      vim.notify("Cleared Harpoon marks")
    end, { desc = "Clear Harpoon marks" })

    vim.keymap.set("n", "gj", function()
      require("harpoon.ui").nav_file(1)
    end, { desc = "Go to harpoon 1" })

    vim.keymap.set("n", "gk", function()
      require("harpoon.ui").nav_file(2)
    end, { desc = "Go to harpoon 2" })

    vim.keymap.set("n", "gl", function()
      require("harpoon.ui").nav_file(3)
    end, { desc = "Go to harpoon 3" })

    vim.keymap.set("n", "gñ", function()
      require("harpoon.ui").nav_file(4)
    end, { desc = "Go to harpoon 4" })
  end,
}
