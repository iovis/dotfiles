local M = {
  "mfussenegger/nvim-dap",
  enabled = false,
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
}

function M.config()
  -- TODO: Still very broken
  ---@diagnostic disable: redefined-local
  local ok, dap = pcall(require, "dap")
  if not ok then
    print("dap not found!")
    return
  end

  ---- DAP Virtual Text
  local ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
  if ok then
    dap_virtual_text.setup()
  end

  ---- DAP UI
  local ok, dapui = pcall(require, "dapui")
  if ok then
    require("dapui").setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end

  ---- Mappings
  vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
  vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "DAP Step Over" })
  vim.keymap.set("n", "<leader>ds", dap.step_into, { desc = "DAP Step Into" })
  vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "DAP Terminate" })
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
  -- nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
  -- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
  -- nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
  -- nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

  ---- Rust
  dap.adapters.lldb = {
    type = "executable",
    command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
    name = "lldb",
  }

  dap.configurations.rust = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input({
          prompt = "Path to executable: ",
          default = vim.fn.getcwd() .. "/target/debug/",
          completion = "file",
        })
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},

      -- 💀
      -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
      --
      --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      --
      -- Otherwise you might get the following error:
      --
      --    Error on launch: Failed to attach to the target process
      --
      -- But you should be aware of the implications:
      -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
      -- runInTerminal = false,
    },
  }
end

return M
