local u = require("config.utils")

-- TODO: why does this fail?
-- vim.opt_local.indentkeys:remove({ ".", "0{" })

vim.cmd.compiler("ruby")

vim.keymap.set("n", "s<cr>", "<cmd>Tux ruby %:.<cr>", { buffer = true })

---- Runnables
if u.current_path():match("/co/manage") then
  vim.g["test#strategy"] = "script_spring"
  vim.g["test#ruby#bundle_exec"] = 0
elseif u.current_file():match("exe/") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bundle exec %:.<cr>", { buffer = true })
elseif u.current_file():match("_spec.rb") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux rspec %:.<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>sd", ":TestFile --format documentation<cr>", { buffer = true, silent = true })
  vim.keymap.set("n", "<leader>sp", ":TestNearest -strategy=test_prof<cr>", { buffer = true, silent = true })

  vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Run RSpec on save",
    group = vim.api.nvim_create_augroup("rspec_runner", { clear = true }),
    buffer = vim.api.nvim_get_current_buf(),
    callback = require("config.hooks.rspec").run,
  })

  ---- Toggle autotest
  vim.keymap.set("n", "<leader>TD", function()
    vim.g.autotest = nil
    vim.notify("Autotest disabled")
  end, { buffer = true, desc = "Autotest disable" })

  vim.keymap.set("n", "<leader>TL", function()
    vim.g.autotest = "line"
    vim.notify("Autotest line")
  end, { buffer = true, desc = "Autotest line" })

  vim.keymap.set("n", "<leader>TF", function()
    vim.g.autotest = "file"
    vim.notify("Autotest file")
  end, { buffer = true, desc = "Autotest file" })

  vim.keymap.set("n", "<leader>TT", function()
    vim.ui.select({ "file", "line", "disable" }, {
      prompt = "RSpec> ",
      format_item = function(item)
        local is_current = ""

        if vim.g.autotest == item or (vim.g.autotest == nil and item == "disable") then
          is_current = " (current)"
        end

        return item .. is_current
      end,
    }, function(choice)
      if choice == "disable" then
        vim.g.autotest = nil
      else
        vim.g.autotest = choice
      end
    end)
  end, { buffer = true, desc = "Toggle autotest" })

  ---- Load failing tests in a scratch window
  vim.api.nvim_buf_create_user_command(0, "FailedRSpecTests", function()
    vim.cmd("R .")
    vim.cmd("r tmp/rspec-failures.txt")
    vim.cmd([[v/| failed/d]])

    local ok, _ = pcall(vim.cmd, [[%s/\v[\d.*]])
    vim.cmd.nohlsearch()

    if not ok then
      vim.cmd("norm! Ino failed tests!")
      return
    end

    vim.cmd("sort u")
    vim.cmd("%norm! Irspec ")
    vim.cmd("se ft=sh")
  end, {})
elseif u.current_file() == "Gemfile" then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bundle install<cr>", { buffer = true })

  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
    desc = "Check bundler dependencies",
    group = vim.api.nvim_create_augroup("bundler_dependencies", { clear = true }),
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      require("config.hooks.dependencies").run("bundler")
    end,
  })
end
