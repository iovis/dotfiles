vim.g.neotest_enabled = false

return {
  "nvim-neotest/neotest",
  enabled = vim.g.neotest_enabled,
  event = "VeryLazy",
  dependencies = {
    "lawrence-laz/neotest-zig",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-plenary",
    "olimorris/neotest-rspec",
    -- "nvim-neotest/neotest-vim-test",
    --------
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-go"),
        require("neotest-plenary"),
        -- require("rustaceanvim.neotest"), -- TODO: nvim v0.10
        require("neotest-zig"),
        require("neotest-rspec")({
          rspec_cmd = function()
            local u = require("config.utils")

            if u.is_executable("bin/spring") then
              return vim.tbl_flatten({
                "bin/spring",
                "rspec",
              })
            else
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rspec",
              })
            end
          end,
        }),
      },
    })

    vim.keymap.set("n", "<leader>si", function()
      neotest.run.run()
    end, { desc = "Neotest: Run nearest" })

    vim.keymap.set("n", "<leader>so", function()
      neotest.run.run(vim.fn.expand("%"))
    end, { desc = "Neotest: Run file" })

    vim.keymap.set("n", "<leader>st", function()
      neotest.run.stop()
    end, { desc = "Neotest: Stop tests" })

    vim.keymap.set("n", "<leader>sw", function()
      neotest.watch.toggle(vim.fn.expand("%"))
    end, { desc = "Neotest: Watch file" })

    vim.keymap.set("n", "<leader>sW", function()
      neotest.watch.toggle()
    end, { desc = "Neotest: Watch nearest" })

    vim.keymap.set("n", "<leader>sl", function()
      neotest.summary.toggle()
    end, { desc = "Neotest: Summary" })

    vim.keymap.set("n", "<leader>sh", function()
      neotest.output.open({ enter = true })
    end, { desc = "Neotest: Output panel" })

    vim.keymap.set("n", "<leader>sm", function()
      neotest.output_panel.toggle()
    end, { desc = "Neotest: Output panel" })

    vim.keymap.set("n", "<leader>sM", function()
      neotest.output_panel.clear()
    end, { desc = "Neotest: Clear Output panel" })

    vim.keymap.set("n", "<leader>sk", function()
      neotest.jump.prev()
    end, { desc = "Neotest: Previous test" })

    vim.keymap.set("n", "<leader>sj", function()
      neotest.jump.next()
    end, { desc = "Neotest: Next test" })
  end,
}
