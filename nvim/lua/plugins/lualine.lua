require("lualine").setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    theme = "base16",
  },
  sections = {
    lualine_a = {},
    lualine_b = {
      {
        "filetype",
        icon_only = true,
      },
      "filename",
    },
    lualine_c = { "branch" },
    lualine_x = { "diff", "diagnostics", "fileformat" },
    lualine_y = { "progress", "location" },
    lualine_z = {},
  },
  extensions = { "fugitive", "nvim-tree", "quickfix", "fzf" },
})
