local M = {
  "windwp/nvim-autopairs",
  event = "VeryLazy",
}

function M.config()
  local ok, autopairs = pcall(require, "nvim-autopairs")
  if not ok then
    print("nvim-autopairs not found!")
    return
  end

  autopairs.setup({
    check_ts = true,
    disable_filetype = { "TelescopePrompt", "fzf" },
    disable_in_macro = true,
  })
end

return M
