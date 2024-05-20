return {
  "mfussenegger/nvim-dap",
  enabled = false,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dap_virtual_text = require("nvim-dap-virtual-text")
    local dapui = require("dapui")

    dapui.setup()
    dap_virtual_text.setup({})

    ---- Listeners
    dap.listeners.before.attach.dapui_config = dapui.open
    dap.listeners.before.launch.dapui_config = dapui.open
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close

    ---- Mappings
    vim.keymap.set("n", "<leader>B", dap.toggle_breakpoint, { desc = "DAP Toggle breakpoint" })
    vim.keymap.set("n", "'dl", dap.run_to_cursor, { desc = "DAP Go to line" })

    vim.keymap.set("n", "'db", dap.step_back, { desc = "DAP Step back" })
    vim.keymap.set("n", "'dc", dap.continue, { desc = "DAP Continue" })
    vim.keymap.set("n", "'dn", dap.step_over, { desc = "DAP Step over" })
    vim.keymap.set("n", "'do", dap.step_out, { desc = "DAP Step out" })
    vim.keymap.set("n", "'ds", dap.step_into, { desc = "DAP Step into" })
    vim.keymap.set("n", "'dt", dap.terminate, { desc = "DAP Terminate" })

    ---- Signs
    vim.fn.sign_define("DapBreakpoint", {
      text = "●",
      texthl = "DapBreakpoint",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapBreakpointCondition", {
      text = "●",
      texthl = "DapBreakpointCondition",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapLogPoint", {
      text = "◆",
      texthl = "DapLogPoint",
      linehl = "",
      numhl = "",
    })
  end,
}
