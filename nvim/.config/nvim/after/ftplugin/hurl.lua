local u = require("config.utils")

local hurl_request = function()
  local filename = vim.fn.expand("%:.")

  vim.system({ "hurl", filename }, { text = true }, function(obj)
    vim.schedule(function()
      local lines = vim.split(obj.stdout, "\n", { plain = true })

      u.scratch(lines, {
        type = "vertical",
        filetype = "json",
        winbar = "hurl " .. filename,
      })
    end)
  end)
end

vim.keymap.set("n", "s<cr>", hurl_request, { buffer = true })
vim.keymap.set("n", "<leader>so", "<cmd>Tux hurl -v %:.<cr>", { buffer = true })
