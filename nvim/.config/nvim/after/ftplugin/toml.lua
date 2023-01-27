local u = require("config.utils")

---- muxi
if string.match(vim.fn.expand("%"), "muxi/") then
  vim.keymap.set("n", "m<cr>", ":silent !muxi init<cr>", { buffer = true })

  -- If only buffer, enable zen-mode
  if u.is_only_buffer() then
    vim.schedule(function()
      require("zen-mode").toggle({})
    end)
  end
end
